// project cuefile for Dagger CI and other development tooling related to this project.
package main

import "dagger.io/dagger"

import "universe.dagger.io/bash"

import "universe.dagger.io/docker"

// Convenience cuelang build for formatting, etc.
#CueBuild: {
	// client filesystem
	filesystem: dagger.#FS

	// output from the build
	output: _cue_build.output

	// cuelang pre-build
	_cue_pre_build: docker.#Build & {
		steps: [
			docker.#Pull & {
				source: "golang:latest"
			},
			docker.#Run & {
				command: {
					name: "mkdir"
					args: ["/workdir"]
				}
			},
			docker.#Run & {
				command: {
					name: "go"
					args: ["install", "cuelang.org/go/cmd/cue@latest"]
				}
			},
		]
	}
	// cue build for actions in this plan
	_cue_build: docker.#Build & {
		steps: [
			docker.#Copy & {
				input:    _cue_pre_build.output
				contents: filesystem
				source:   "./project.cue"
				dest:     "/workdir/project.cue"
			},
		]
	}

}

#TFLintBuild: {
	// client filesystem
	filesystem: dagger.#FS

	// output from the build
	output: _tf_build.output

	// tf build
	_tf_build: docker.#Build & {
		steps: [
			docker.#Pull & {
				source: "ghcr.io/antonbabenko/pre-commit-terraform:v1.83.3"
			},
			docker.#Set & {
				config: {
					workdir: "/lint"
				}
			},

			docker.#Copy & {
				contents: filesystem
				source:   "./"
				dest:     "/workdir"
			},
			bash.#Run & {
				script: contents: """
					# cd into the workdir
					cd /workdir

					# remove already existing test content
					rm -rf ./tests/lab-initiative-bucket

					# install poetry and env
					python3 -m pip install --no-cache-dir --upgrade poetry
					poetry install --no-interaction --no-ansi

					# run cookiecutter to create project from template
					poetry run cookiecutter . --no-input --output-dir tests

					# move project from template into lintable dir for container
					cp -ra /workdir/tests/lab-initiative-bucket/. /lint

					# reinit git for the cookiecutter project
					rm -rf /lint/.git
					cd /lint
					git config --global user.email "you@example.com"
					git config --global user.name "Your Name"
					git init
					git add .
					git commit -m "example message"
					"""
			},
		]
	}

}

dagger.#Plan & {

	client: {
		filesystem: {
			"./": read: contents:             dagger.#FS
			"./project.cue": write: contents: actions.format.cue.export.files."/workdir/project.cue"
		}
	}

	actions: {

		// an internal cue build for formatting/cleanliness
		_cue_build: #CueBuild & {
			filesystem: client.filesystem."./".read.contents
		}

		// an internal terraform build for use with this repo
		_tf_lint_build: #TFLintBuild & {
			filesystem: client.filesystem."./".read.contents
		}

		// applied code and/or file formatting
		format: {
			// code formatting for cuelang
			cue: docker.#Run & {
				input:   _cue_build.output
				workdir: "/workdir"
				command: {
					name: "cue"
					args: ["fmt", "/workdir/project.cue"]
				}
				export: {
					files: "/workdir/project.cue": _
				}
			}
		}

		test: {
			// run pre-commit checks
			test_pre_commit: bash.#Run & {
				input: _tf_lint_build.output
				script: contents: """
					pre-commit run -a
				"""
			},

				// run pre-commit checks
				test_tfvars: bash.#Run & {
					input: _tf_lint_build.output
					script: contents: """
							# change dir to where the cookiecutter created project lives
							# to simulate the use of the directory after it's been used
							cd /lint

							# set terraform to use mock credentials for testing
							export GOOGLE_APPLICATION_CREDENTIALS=/workdir/tests/data/gcp-mock-credentials.json

							# initialize terraform for plan
							terraform -chdir=terraform/state-management init
							
							# run plan without explicit input from cli
							# note: we expect variables to be inherited from terraform.tfvars or similar
							# this command will fail when unable to read a related tfvars file
							# see the following for more info:
							# https://developer.hashicorp.com/terraform/language/values/variables#variable-definition-precedence
							terraform -chdir=terraform/state-management plan -input=false
						"""
				}
			}
		}

	}

