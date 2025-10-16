output "container_fqdn" {
  description = "FQDN of the deployed container"
  value       = azurerm_container_group.aci.fqdn
}