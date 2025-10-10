provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "lab_rg" {
  name     = var.resource_group
  location = var.location
}

resource "azurerm_virtual_network" "core_services" {
  name                = var.core_vnet_name
  address_space       = [var.core_vnet_address_space]
  location            = var.location
  resource_group_name = azurerm_resource_group.lab_rg.name
}

resource "azurerm_subnet" "shared_services" {
  name                 = var.shared_subnet_name
  resource_group_name  = azurerm_resource_group.lab_rg.name
  virtual_network_name = azurerm_virtual_network.core_services.name
  address_prefixes     = [var.shared_subnet_prefix]
}

resource "azurerm_subnet" "database" {
  name                 = var.database_subnet_name
  resource_group_name  = azurerm_resource_group.lab_rg.name
  virtual_network_name = azurerm_virtual_network.core_services.name
  address_prefixes     = [var.database_subnet_prefix]
}

resource "azurerm_resource_group_template_deployment" "manufacturing_vnet" {
  name                = "manufacturing-vnet-deployment"
  resource_group_name = azurerm_resource_group.lab_rg.name
  deployment_mode     = "Incremental"

  template_content    = file("${path.module}/templates/manufacturing.template.json")
  parameters_content  = file("${path.module}/templates/manufacturing.parameters.json")
}

resource "azurerm_application_security_group" "asg_web" {
  name                = var.asg_name
  location            = var.location
  resource_group_name = azurerm_resource_group.lab_rg.name
}

resource "azurerm_network_security_group" "nsg_secure" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = azurerm_resource_group.lab_rg.name
}

resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  subnet_id                 = azurerm_subnet.shared_services.id
  network_security_group_id = azurerm_network_security_group.nsg_secure.id
}

resource "azurerm_network_security_rule" "allow_asg" {
  name                        = "AllowASG"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["80", "443"]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.lab_rg.name
  network_security_group_name = azurerm_network_security_group.nsg_secure.name
}

resource "azurerm_network_security_rule" "deny_internet" {
  name                        = "DenyInternetOutbound"
  priority                    = 4096
  direction                   = "Outbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "Internet"
  resource_group_name         = azurerm_resource_group.lab_rg.name
  network_security_group_name = azurerm_network_security_group.nsg_secure.name
}

resource "azurerm_dns_zone" "public_zone" {
  name                = var.public_dns_zone_name
  resource_group_name = azurerm_resource_group.lab_rg.name
}

resource "azurerm_dns_a_record" "public_www" {
  name                = "www"
  zone_name           = azurerm_dns_zone.public_zone.name
  resource_group_name = azurerm_resource_group.lab_rg.name
  ttl                 = 1
  records             = [var.public_dns_ip]
}

resource "azurerm_private_dns_zone" "private_zone" {
  name                = var.private_dns_zone_name
  resource_group_name = azurerm_resource_group.lab_rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link" {
  name                  = var.private_dns_link_name
  resource_group_name   = azurerm_resource_group.lab_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.private_zone.name
  virtual_network_id    = azurerm_virtual_network.core_services.id
  registration_enabled  = false
}

resource "azurerm_private_dns_a_record" "sensor_vm" {
  name                = "sensorvm"
  zone_name           = azurerm_private_dns_zone.private_zone.name
  resource_group_name = azurerm_resource_group.lab_rg.name
  ttl                 = 1
  records             = [var.private_dns_ip]
}