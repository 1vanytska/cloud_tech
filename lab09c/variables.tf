variable "resource_group_name" {
  description = "Name of the existing resource group"
  default     = "az104-rg9"
}

variable "container_app_name" {
  description = "Name of the container app"
  default     = "my-app"
}

variable "container_app_environment_name" {
  description = "Name of the container app environment"
  default     = "my-environment"
}