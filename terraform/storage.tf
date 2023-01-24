# tf for creating storage
#tfsec:ignore:google-storage-bucket-encryption-customer-key
resource "google_storage_bucket" "target_bucket" {
  name                        = var.bucket_name
  location                    = var.region
  uniform_bucket_level_access = true
  labels = {
    "initiative_label" : var.initiative_label
  }
}

resource "google_storage_bucket_iam_member" "member" {
  bucket = google_storage_bucket.target_bucket.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.service_account.email}"
}
