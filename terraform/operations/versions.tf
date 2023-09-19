# tf versions
terraform {
  required_version = "~> 1.3.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.50.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.3.0"
    }
  }
}
