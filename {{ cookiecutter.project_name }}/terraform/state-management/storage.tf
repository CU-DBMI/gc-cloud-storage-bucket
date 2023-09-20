# tf for creating storage
#tfsec:ignore:google-storage-bucket-encryption-customer-key
resource "google_storage_bucket" "state_bucket" {
  name                        = var.bucket_name
  location                    = var.region
  uniform_bucket_level_access = true
  labels = {
    "initiative_label" : var.initiative_label
  }
}
