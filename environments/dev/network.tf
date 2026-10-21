module "network" {
  source = "../../modules/network"

  name                = "vnet-lz-${var.environment}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = ["10.10.0.0/16"]
  tags                = local.tags

  subnets = {
    snet-web = { address_prefixes = ["10.10.1.0/24"] }
    snet-app = { address_prefixes = ["10.10.2.0/24"] }
  }
}

resource "azurerm_network_security_group" "web" {
  name                = "nsg-web-${var.environment}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = local.tags

  security_rule {
    name                       = "Allow-HTTPS-From-VNet"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "web" {
  subnet_id                 = module.network.subnet_ids["snet-web"]
  network_security_group_id = azurerm_network_security_group.web.id
}

moved {
  from = azurerm_virtual_network.main
  to   = module.network.azurerm_virtual_network.this
}

moved {
  from = azurerm_subnet.web
  to   = module.network.azurerm_subnet.this["snet-web"]
}

moved {
  from = azurerm_subnet.app
  to   = module.network.azurerm_subnet.this["snet-app"]
}