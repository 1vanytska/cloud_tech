variable "resource_group" {
  default = "az104-rg4"
}

variable "location" {
  default = "East US"
}

variable "core_vnet_name" {
  default = "CoreServicesVnet"
}

variable "core_vnet_address_space" {
  default = "10.20.0.0/16"
}

variable "shared_subnet_name" {
  default = "SharedServicesSubnet"
}

variable "shared_subnet_prefix" {
  default = "10.20.10.0/24"
}

variable "database_subnet_name" {
  default = "DatabaseSubnet"
}

variable "database_subnet_prefix" {
  default = "10.20.20.0/24"
}

variable "asg_name" {
  default = "asg-web"
}

variable "nsg_name" {
  default = "myNSGSecure"
}

variable "public_dns_zone_name" {
  default = "sofiia-lab04-x9v7q2z3k8r1a6b4.com"
}

variable "public_dns_ip" {
  default = "10.1.1.4"
}

variable "private_dns_zone_name" {
  default = "private.contoso.com"
}

variable "private_dns_link_name" {
  default = "manufacturing-link"
}

variable "private_dns_ip" {
  default = "10.1.1.4"
}