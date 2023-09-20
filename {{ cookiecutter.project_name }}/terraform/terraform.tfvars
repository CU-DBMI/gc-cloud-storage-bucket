# tf variables
variable "project" {
  description = "Google Cloud project to create the related resources in."
  type        = string
  default     = "{{ cookiecutter.project_gc_project }}"
}

variable "region" {
  description = "Google Cloud region to be used with the project resources"
  type        = string
  default     = "{{ cookiecutter.project_gc_region }}"
}

variable "bucket_name" {
  description = "Name for the bucket being created."
  type        = string
  default     = "{{ cookiecutter.project_name }}"
}

variable "initiative_label" {
  description = "Label for specific initiative useful for differentiating between various resources."
  type        = string
  default     = "{{ cookiecutter.project_name }}"
}
