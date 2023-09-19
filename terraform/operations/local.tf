# tf local output
resource "local_file" "service_account_key" {
  filename = "../utilities/data-provider/service-account.json"
  content  = base64decode(google_service_account_key.key.private_key)
}
