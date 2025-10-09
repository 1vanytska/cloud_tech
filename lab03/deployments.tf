resource "azurerm_resource_group_template_deployment" "arm_redeploy" {
  name                = "arm-redeploy-disk2"
  resource_group_name = azurerm_resource_group.rg.name
  deployment_mode     = "Incremental"

  template_content = file("${path.module}/templates/template.json")

  parameters_content = jsonencode({
    disk_name    = { value = "az104-disk2" }
    location     = { value = "eastus" }
    disk_size_gb = { value = 32 }
    sku          = { value = "Standard_LRS" }
  })
}

resource "azurerm_resource_group_template_deployment" "arm_redeploy_modified" {
  name                = "arm-redeploy-disk3"
  resource_group_name = azurerm_resource_group.rg.name
  deployment_mode     = "Incremental"

  template_content = file("${path.module}/templates/template.json")

  parameters_content = jsonencode({
    disk_name = { value = "az104-disk3" }
  })
}

resource "azurerm_resource_group_template_deployment" "bicep_deploy" {
  name                = "bicep-deploy-disk5"
  resource_group_name = azurerm_resource_group.rg.name
  deployment_mode     = "Incremental"

  template_content   = file("${path.module}/templates/azuredeploydisk.json")
  parameters_content = "{}"
}