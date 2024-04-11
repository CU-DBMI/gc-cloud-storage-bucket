# tf variables
variable "project" {
  description = "Google Cloud project to create the related resources in."
  type        = string
  validation {
    condition     = length(var.project) >= 4 && length(var.project) <= 30
    error_message = "Project name must be between 4 and 30 characters."
  }
}

variable "region" {
  description = "Google Cloud region to be used with the project resources"
  type        = string
}

variable "bucket_name" {
  description = "Name for the bucket being created."
  type        = string
  validation {
    condition     = length(var.bucket_name) >= 3 && length(var.bucket_name) <= 63
    error_message = "Bucket name must be between 3 and 63 characters."
  }
}

variable "initiative_label" {
  description = "Label for specific initiative useful for differentiating between various resources."
  type        = string
  validation {
    condition     = length(var.initiative_label) >= 6 && length(var.initiative_label) <= 21
    error_message = "Initiative label must be between 6 and 23 characters."
  }
}
