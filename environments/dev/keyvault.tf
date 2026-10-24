resource "azurerm_resource_group" "security" {
  name     = "rg-lz-security-${var.environment}"
  location = var.location

  tags = local.tags
}

module "keyvault" {
  source = "../../modules/keyvault"

  name                = "kv-lz-${var.environment}-${substr(data.azurerm_subscription.current.subscription_id, 0, 6)}"
  location            = var.location
  resource_group_name = azurerm_resource_group.security.name
  tenant_id           = data.azurerm_subscription.current.tenant_id

  tags = local.tags
}

resource "azurerm_monitor_diagnostic_setting" "key_vault" {
  name                       = "kv-audit-to-law"
  target_resource_id         = module.keyvault.id
  log_analytics_workspace_id = module.monitoring.workspace_id

  enabled_log {
    category_group = "audit"
  }
}
