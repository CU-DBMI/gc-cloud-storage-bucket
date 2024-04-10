# tf account creation and related work
# Create a new service account
resource "google_service_account" "service_account" {
  # note: template may have truncated the project name due to character limits
  # for Google service accounts. See the following for more information:
  # https://cloud.google.com/iam/docs/service-accounts-create#creating
  account_id = "{{ cookiecutter.project_name[:21] }}-svc-acct"
}

#Create a service-account key for the associated service account
resource "google_service_account_key" "key" {
  service_account_id = google_service_account.service_account.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}
