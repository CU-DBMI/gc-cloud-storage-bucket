# Terraform Docs

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.4.6 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.66.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | ~> 2.4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.66.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_service_account.service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_key.key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_key) | resource |
| [google_storage_bucket.target_bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_iam_binding.bucket_get_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_binding) | resource |
| [google_storage_bucket_iam_member.member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |
| [local_file.service_account_key](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Name for the bucket being created | `string` | `"waylab-durbinlab-bucket"` | no |
| <a name="input_initiative_label"></a> [initiative\_label](#input\_initiative\_label) | Label for specific initiative useful for differentiating between various resources | `string` | `"waylab-durbinlab"` | no |
| <a name="input_project"></a> [project](#input\_project) | tf variables project to create the related resources in | `string` | `"cuhealthai-sandbox"` | no |
| <a name="input_region"></a> [region](#input\_region) | Region to be used with the project resources | `string` | `"us-central1"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
