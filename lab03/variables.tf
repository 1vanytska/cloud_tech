variable "location" {
  type    = string
  default = "eastus"
}

variable "resource_group_name" {
  type    = string
  default = "az104-rg3"
}

variable "disk_size_gib" {
  type    = number
  default = 32
}

variable "disk_names" {
  type    = list(string)
  default = ["az104-disk1", "az104-disk2", "az104-disk3", "az104-disk4", "az104-disk5"]
}