# tf versions
terraform {
  required_version = "~> 1.5.7"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.83.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4.0"
    }
  }
}
