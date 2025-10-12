output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "storage_account_id" {
  value = azurerm_storage_account.storage.id
}

output "blob_container_url" {
  value = "https://${azurerm_storage_account.storage.name}.blob.core.windows.net/${azurerm_storage_container.data.name}"
}

output "file_share_url" {
  value = "https://${azurerm_storage_account.storage.name}.file.core.windows.net/${azurerm_storage_share.share1.name}"
}