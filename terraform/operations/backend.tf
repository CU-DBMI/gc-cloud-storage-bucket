# tf backend setup enabling state management bucket
terraform {
  backend "gcs" {
    bucket = "{{ cookiecutter.project_name }}-state-mgmt"
    prefix = "terraform/state"
  }
}
