// project cuefile for Dagger CI and other development tooling related to this project.
package main

import "dagger.io/dagger"

import "universe.dagger.io/bash"

import "universe.dagger.io/docker"

// python build for linting, testing, building, etc.
#PythonBuild: {
	// client filesystem
	filesystem: dagger.#FS

	// python version to use for build
	python_ver: string | *"3.9"

	// poetry version to use for build
	poetry_ver: string | *"1.2"

	// container image
	output: _python_pre_build.output

	// referential build for base python image
	_python_pre_build: docker.#Build & {
		steps: [
			docker.#Pull & {
				source: "python:" + python_ver
			},
			docker.#Run & {
				command: {
					name: "mkdir"
					args: ["/workdir"]
				}
			},
			docker.#Set & {
				config: {
					workdir: "/workdir"
					env: {
						POETRY_VIRTUALENVS_CREATE: "false"
					}
				}
			},
			docker.#Copy & {
				contents: filesystem
				source:   "./pyproject.toml"
				dest:     "/workdir/pyproject.toml"
			},
			docker.#Copy & {
				contents: filesystem
				source:   "./poetry.lock"
				dest:     "/workdir/poetry.lock"
			},
			docker.#Copy & {
				contents: filesystem
				source:   "./.pre-commit-config.yaml"
				dest:     "/workdir/.pre-commit-config.yaml"
			},
			docker.#Run & {
				command: {
					name: "pip"
					args: ["install", "--no-cache-dir", "poetry==" + poetry_ver]
				}
			},
			docker.#Run & {
				command: {
					name: "poetry"
					args: ["install", "--no-root", "--no-interaction", "--no-ansi"]
				}
			},
			// init for pre-commit install
			docker.#Run & {
				command: {
					name: "git"
					args: ["init"]
				}
			},
			docker.#Run & {
				command: {
					name: "poetry"
					args: ["run", "pre-commit", "install-hooks"]
				}
			},
		]
	}
}

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
				source: "ghcr.io/antonbabenko/pre-commit-terraform:latest"
			},
			docker.#Set & {
				config: {
					workdir: "/lint"
				}
			},
			docker.#Copy & {
				contents: filesystem
				source:   "./"
				dest:     "/lint"
			},
		]
	}

}

// Convenience terraform build for implementation
#TerraformBuild: {
	// client filesystem
	filesystem: dagger.#FS

	// output from the build
	output: _tf_build.output

	// tf build
	_tf_build: docker.#Build & {
		steps: [
			docker.#Pull & {
				source: "hashicorp/terraform:latest"
			},
			docker.#Run & {
				command: {
					name: "mkdir"
					args: ["/workdir"]
				}
			},
			docker.#Copy & {
				contents: filesystem
				source:   "./"
				dest:     "/workdir/"
			},
		]
	}

}

dagger.#Plan & {

	client: {
		filesystem: {
			"./": read: contents:             dagger.#FS
			"./project.cue": write: contents: actions.format.cue.export.files."/workdir/project.cue"
			"./": write: contents:            actions.format.pre_commit.export.directories."/lint"
		}
	}
	python_version: string | *"3.9"
	poetry_version: string | *"1.2"

	actions: {

		// an internal python build for use with other actions
		_python_build: #PythonBuild & {
			filesystem: client.filesystem."./".read.contents
			python_ver: python_version
			poetry_ver: poetry_version
		}

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
			// run pre-commit checks
			pre_commit: bash.#Run & {
				input: _tf_lint_build.output
				script: contents: """
					: $(pre-commit run --all-files)
					"""
				export: {
					directories: {"/lint": _}
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
