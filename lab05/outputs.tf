output "core_vm_private_ip" {
  value = azurerm_network_interface.core_nic.private_ip_address
}

output "manufacturing_vm_private_ip" {
  value = azurerm_network_interface.manufacturing_nic.private_ip_address
}

output "core_vnet_id" {
  value = azurerm_virtual_network.core_vnet.id
}

output "manufacturing_vnet_id" {
  value = azurerm_virtual_network.manufacturing_vnet.id
}

output "core_route_table_id" {
  value = azurerm_route_table.core_route_table.id
}

output "peering_core_to_manufacturing_id" {
  value = azurerm_virtual_network_peering.core_to_manufacturing.id
}

output "peering_manufacturing_to_core_id" {
  value = azurerm_virtual_network_peering.manufacturing_to_core.id
}