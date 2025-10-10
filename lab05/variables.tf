variable "resource_group" {
  default = "az104-rg5"
}

variable "location" {
  default = "East US"
}

variable "core_vnet_name" {
  default = "CoreServicesVnet"
}

variable "core_vnet_address_space" {
  default = "10.0.0.0/16"
}

variable "core_subnet_name" {
  default = "Core"
}

variable "core_subnet_prefix" {
  default = "10.0.0.0/24"
}

variable "core_vm_name" {
  default = "CoreServicesVM"
}

variable "manufacturing_vnet_name" {
  default = "ManufacturingVnet"
}

variable "manufacturing_vnet_address_space" {
  default = "172.16.0.0/16"
}

variable "manufacturing_subnet_name" {
  default = "Manufacturing"
}

variable "manufacturing_subnet_prefix" {
  default = "172.16.0.0/24"
}

variable "manufacturing_vm_name" {
  default = "ManufacturingVM"
}

variable "vm_size" {
  default = "Standard_B2ms"
}

variable "admin_username" {
  default = "localadmin"
}

variable "admin_password" {
  default = "ComplexPassword123!"
}

variable "perimeter_subnet_name" {
  default = "perimeter"
}

variable "perimeter_subnet_prefix" {
  default = "10.0.1.0/24"
}

variable "route_table_name" {
  default = "rt-CoreServices"
}

variable "route_name" {
  default = "PerimetertoCore"
}

variable "nva_ip" {
  default = "10.0.1.7"
}