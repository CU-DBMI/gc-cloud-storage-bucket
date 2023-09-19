# tf backend setup enabling state management bucket
terraform {
  backend "gcs" {
    bucket = "lab-initiative-bucket-state-mgmt"
    prefix = "terraform/state"
  }
}
