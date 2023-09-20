# tf variables
# project to create the related resources in
variable "project" {
  type    = string
  default = "{{ cookiecutter.project_gc_project }}"
}
# Region to be used with the project resources
variable "region" {
  type    = string
  default = "{{ cookiecutter.project_gc_region }}"
}
# Name for the bucket being created
variable "bucket_name" {
  type    = string
  default = "{{ cookiecutter.project_name }}-state-mgmt"
}
# Label for specific initiative
# useful for differentiating between
# various resources
variable "initiative_label" {
  type    = string
  default = "{{ cookiecutter.project_name }}"
}
