# =====================================================================
# MODULE: network
# A reusable "blueprint" that builds one self-contained network stack:
#   a resource group + a VNet + however many subnets you hand it.
# It knows NOTHING about East US, West US, or any specific name.
# All of that comes IN as variables. That is what makes it reusable.
# =====================================================================

resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = var.address_space
  tags                = var.tags
}

# for_each loops over the subnets map the caller passes in.
# Pass 2 subnets -> get 2. Pass 5 -> get 5. The module doesn't care.
resource "azurerm_subnet" "this" {
  for_each = var.subnets

  name                 = each.key
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [each.value]
}
