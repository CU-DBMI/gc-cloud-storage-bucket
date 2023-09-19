# tf backend setup enabling state management bucket
terraform {
  backend "gcs" {
    bucket = "waylab-durbinlab-bucket-state-mgmt"
    prefix = "terraform/state"
  }
}
