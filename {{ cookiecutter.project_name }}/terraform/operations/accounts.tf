# tf account creation and related work
# Create a new service account
resource "google_service_account" "service_account" {
  account_id = "${var.initiative_label}-svc-account"
}

#Create a service-account key for the associated service account
resource "google_service_account_key" "key" {
  service_account_id = google_service_account.service_account.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}
