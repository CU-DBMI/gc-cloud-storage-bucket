# state-management

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5.7 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.83.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 4.83.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_storage_bucket.state_bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Name for the bucket being created. | `string` | n/a | yes |
| <a name="input_initiative_label"></a> [initiative\_label](#input\_initiative\_label) | Label for specific initiative useful for differentiating between various resources. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Google Cloud project to create the related resources in. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Google Cloud region to be used with the project resources | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
