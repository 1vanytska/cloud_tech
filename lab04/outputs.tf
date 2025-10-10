output "resource_group_name" {
  value = azurerm_resource_group.lab_rg.name
}

output "core_vnet_id" {
  value = azurerm_virtual_network.core_services.id
}

output "shared_subnet_id" {
  value = azurerm_subnet.shared_services.id
}

output "database_subnet_id" {
  value = azurerm_subnet.database.id
}

output "manufacturing_vnet_deployment_name" {
  value = azurerm_resource_group_template_deployment.manufacturing_vnet.name
}

output "asg_web_id" {
  value = azurerm_application_security_group.asg_web.id
}

output "nsg_secure_id" {
  value = azurerm_network_security_group.nsg_secure.id
}

output "public_dns_zone_name_servers" {
  value = azurerm_dns_zone.public_zone.name_servers
}

output "private_dns_zone_id" {
  value = azurerm_private_dns_zone.private_zone.id
}