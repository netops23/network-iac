# Outputs are the module's "return values". The caller can't reach inside
# the module to grab a resource attribute directly — it can only see what
# the module chooses to expose here.

output "vnet_id" {
  description = "Resource ID of the created VNet."
  value       = azurerm_virtual_network.this.id
}

output "vnet_name" {
  description = "Name of the created VNet."
  value       = azurerm_virtual_network.this.name
}

output "subnet_ids" {
  description = "Map of subnet name => subnet resource ID."
  value       = { for name, snet in azurerm_subnet.this : name => snet.id }
}
