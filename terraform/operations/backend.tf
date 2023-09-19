# tf backend setup enabling state management bucket
terraform {
  backend "gcs" {
    bucket = "waylab-assayworks-bucket-state-mgmt"
    prefix = "terraform/state"
  }
}
