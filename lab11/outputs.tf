output "vm_name" {
  value = azurerm_windows_virtual_machine.vm.name
}

output "alert_rule_name" {
  value = azurerm_monitor_activity_log_alert.vm_delete_alert.name
}

output "action_group_email" {
  value = var.action_group_email
}