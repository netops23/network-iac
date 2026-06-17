# The root re-exposes the module's outputs so they print after `apply`
# and are queryable with `terraform output`. Notice the chain:
#   resource attribute -> module output -> root output -> your terminal.

output "eastus_vnet_id" {
  description = "ID of the East US VNet."
  value       = module.vnet_eastus.vnet_id
}

output "eastus_subnet_ids" {
  description = "Subnet name => ID map for the East US VNet."
  value       = module.vnet_eastus.subnet_ids
}

# ── PLAY HERE #2 ─────────────────────────────────────────────────────
# Uncomment once you enable the West US module above:
#
# output "westus_vnet_id" {
#   value = module.vnet_westus.vnet_id
# }
