provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_service_plan" "plan" {
  name                = "webapp-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "S1"
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "azurerm_linux_web_app" "webapp" {
  name                = "${var.webapp_name_prefix}-${random_id.suffix.hex}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
    always_on = true
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_linux_web_app_slot" "staging" {
  name             = "staging"
  app_service_id   = azurerm_linux_web_app.webapp.id

  site_config {
    always_on = true
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }
}

resource "azurerm_app_service_source_control_slot" "staging_deploy" {
  slot_id       = azurerm_linux_web_app_slot.staging.id
  repo_url      = "https://github.com/1vanytska/php-docs-hello-world"
  branch        = "master"
  use_mercurial = false
}

resource "null_resource" "swap_slots" {
  provisioner "local-exec" {
    command = "az webapp deployment slot swap --resource-group ${var.resource_group_name} --name ${azurerm_linux_web_app.webapp.name} --slot staging --target-slot production"
  }

  depends_on = [azurerm_app_service_source_control_slot.staging_deploy]
}

resource "azurerm_monitor_autoscale_setting" "autoscale" {
  name                = "webapp-autoscale"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  target_resource_id  = azurerm_service_plan.plan.id

  profile {
    name = "default"
    capacity {
      minimum = "1"
      maximum = "2"
      default = "1"
    }

    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_service_plan.plan.id
        time_grain         = "PT1M"
        time_window        = "PT10M"
        time_aggregation   = "Average"
        statistic          = "Average"
        operator           = "GreaterThan"
        threshold          = 70
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_service_plan.plan.id
        time_grain         = "PT1M"
        time_window        = "PT10M"
        time_aggregation   = "Average"
        statistic          = "Average"
        operator           = "LessThan"
        threshold          = 30
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }
  }

  notification {
  email {
    custom_emails = ["sofiia.ivanytska.22@pnu.edu.ua"]
  }
}
}