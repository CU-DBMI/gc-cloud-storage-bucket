# Terraform Docs

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3.5 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.50.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.50.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_storage_bucket.target_bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_tags_tag_binding.binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/tags_tag_binding) | resource |
| [google_tags_tag_key.key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/tags_tag_key) | resource |
| [google_tags_tag_value.value](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/tags_tag_value) | resource |
| [google_project.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Name for the bucket being created | `string` | n/a | yes |
| <a name="input_initiative_label"></a> [initiative\_label](#input\_initiative\_label) | Label for specific initiative useful for differentiating between various resources | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | tf variables project to create the related resources in | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region to be used with the project resources | `string` | `"us-central1"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
