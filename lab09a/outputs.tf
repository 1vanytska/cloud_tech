output "webapp_url" {
  value = azurerm_linux_web_app.webapp.default_hostname
}

output "staging_slot_url" {
  value = azurerm_linux_web_app_slot.staging.default_hostname
}