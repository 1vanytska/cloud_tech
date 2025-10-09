output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "require_tag_assignment_id" {
  value = azurerm_resource_group_policy_assignment.require_tag_assignment.id
}

output "inherit_tag_assignment_id" {
  value = azurerm_resource_group_policy_assignment.inherit_tag_assignment.id
}

output "lock_id" {
  value = azurerm_management_lock.rg_lock.id
}