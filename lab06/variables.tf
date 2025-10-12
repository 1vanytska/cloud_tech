variable "location" {
  default = "East US"
}

variable "resource_group_name" {
  default = "az104-rg6"
}

variable "admin_username" {
  default = "localadmin"
}

variable "admin_password" {
  description = "Password for the VMs"
  type        = string
  sensitive   = true
}

variable "vm_size" {
  default = "Standard_B1s"
}