variable "resource_group_name" {
  description = "Name of the existing resource group"
  default     = "az104-rg9"
}

variable "location" {
  description = "Azure region (not used directly)"
  default = "Germany West Central"
}

variable "container_name" {
  description = "Name of the container instance"
  default     = "az104-c1"
}

variable "container_image" {
  description = "Docker image to deploy"
  default     = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
}

variable "dns_name_label" {
  description = "Globally unique DNS name label"
  default     = "aci-sofiia-sei84bdka"
}