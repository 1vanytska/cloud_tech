output "vm_id" {
  value       = azurerm_windows_virtual_machine.vm.id
  description = "ID of the deployed virtual machine"
}

output "vault_id_region1" {
  value       = azurerm_recovery_services_vault.rsv1.id
  description = "ID of the Recovery Services Vault in East US"
}

output "vault_id_region2" {
  value       = azurerm_recovery_services_vault.rsv2.id
  description = "ID of the Recovery Services Vault in West US"
}

output "storage_account_name" {
  value       = azurerm_storage_account.diag.name
  description = "Name of the diagnostics storage account"
}