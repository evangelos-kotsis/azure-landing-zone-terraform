data "azurerm_subscription" "current" {}

resource "azurerm_resource_group" "monitoring" {
  name     = "rg-lz-monitoring-${var.environment}"
  location = var.location
  tags     = local.tags
}

module "monitoring" {
  source = "../../modules/monitoring"

  name                = "log-lz-${var.environment}"
  location            = azurerm_resource_group.monitoring.location
  resource_group_name = azurerm_resource_group.monitoring.name
  retention_in_days   = 30
  daily_quota_gb      = 0.5
  tags                = local.tags
}

resource "azurerm_monitor_diagnostic_setting" "activity_log" {
  name                       = "activity-log-to-law"
  target_resource_id         = data.azurerm_subscription.current.id
  log_analytics_workspace_id = module.monitoring.workspace_id

  enabled_log {
    category = "Administrative"
  }

  enabled_log {
    category = "Security"
  }

  enabled_log {
    category = "Policy"
  }
}