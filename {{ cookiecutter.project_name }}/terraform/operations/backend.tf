# tf backend setup enabling state management bucket
terraform {
  backend "gcs" {
    bucket = "${var.bucket_name}-state-mgmt"
    prefix = "terraform/state"
  }
}
