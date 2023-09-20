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

# adds member to bucket with objectAdmin permissions
# see the following link for more information on roles:
# https://cloud.google.com/storage/docs/access-control/iam-roles
resource "google_storage_bucket_iam_member" "member" {
  bucket = google_storage_bucket.target_bucket.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.service_account.email}"
}

# granting additional role for rsync operations
# which require storage.buckets.get access
resource "google_storage_bucket_iam_binding" "bucket_get_binding" {
  bucket = google_storage_bucket.target_bucket.name

  role = "roles/storage.legacyBucketReader"
  members = [
    "serviceAccount:${google_service_account.service_account.email}",
  ]
}
