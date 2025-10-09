output "resource_group_id" {
  description = "Resource group id"
  value       = azurerm_resource_group.rg.id
}

output "disk_ids" {
  description = "IDs of the created managed disks"
  value = [
    azurerm_managed_disk.disk1.id,
    azurerm_managed_disk.disk2.id,
    azurerm_managed_disk.disk3.id,
    azurerm_managed_disk.disk4.id,
    azurerm_managed_disk.disk5.id,
  ]
}

output "disk_names" {
  description = "Names of created managed disks"
  value       = var.disk_names
}