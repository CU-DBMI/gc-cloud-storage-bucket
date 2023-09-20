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
	_tf_pre_build: docker.#Build & {
		steps: [
			docker.#Pull & {
				source: "ghcr.io/antonbabenko/pre-commit-terraform:v1.83.3"
			},
			docker.#Set & {
				config: {
					workdir: "/lint"
				}
			},
			// git init for pre-commit caching
			bash.#Run & {
				script: contents: """
					    git init
					"""
			},
			docker.#Copy & {
				contents: filesystem
				source:   "./.pre-commit-config.yaml"
				dest:     "/lint/.pre-commit-config.yaml"
			},
			docker.#Run & {
				command: {
					name: "install-hooks"
				}
			},
		]
	}

	// cue build for actions in this plan
	_tf_build: docker.#Build & {
		steps: [
			
			docker.#Copy & {
				input:    _tf_pre_build.output
				contents: filesystem
				source:   "./"
				dest:     "/workdir"
				exclude: ["./.pre-commit-config.yaml"]
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
					cp -r /workdir/tests/lab-initiative-bucket /lint
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

		// various tests for this repo
		test: {
			// run pre-commit checks
			test_pre_commit: docker.#Run & {
				input: _tf_lint_build.output
				command: {
					name: "run"
					args: ["--all-files"]
				}
			}
		}
	}
}
