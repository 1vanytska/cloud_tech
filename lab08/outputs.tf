output "vm_names" {
  value = [for vm in azurerm_windows_virtual_machine.vm : vm.name]
}

output "vmss_name" {
  value = azurerm_windows_virtual_machine_scale_set.vmss.name
}

output "vm1_data_disk_id" {
  value = azurerm_managed_disk.vm1_data_disk.id
}

output "vmss_autoscale_setting_name" {
  value = azurerm_monitor_autoscale_setting.vmss_autoscale.name
}