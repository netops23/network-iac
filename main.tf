# =====================================================================
# ROOT MODULE  (this is what you actually run: terraform plan/apply)
# It doesn't create resources directly. It CALLS the network module
# and feeds it inputs. Think of each `module` block as a function call.
# =====================================================================

# ── VNet #1: East US ─────────────────────────────────────────────────
module "vnet_eastus" {
  source = "./modules/network" # where the blueprint lives

  resource_group_name = "rg-network-eastus"
  location            = "East US"
  vnet_name           = "vnet-eastus"
  address_space       = ["10.10.0.0/16"]

  subnets = {
    "snet-app"  = "10.10.1.0/24"
    "snet-data" = "10.10.2.0/24"
  }

  tags = var.common_tags
}


# ── PLAY HERE #1 ─────────────────────────────────────────────────────
# Uncomment this whole block, run `terraform plan`, and watch a SECOND,
# completely independent network stack appear — same module, new inputs.
# THIS is the entire payoff of modules: write the logic once, reuse it.
#
# module "vnet_westus" {
#   source = "./modules/network"
#
#   resource_group_name = "rg-network-westus"
#   location            = "West US"
#   vnet_name           = "vnet-westus"
#   address_space       = ["10.20.0.0/16"]
#
#   subnets = {
#     "snet-app" = "10.20.1.0/24"
#   }
#
#   tags = var.common_tags
# }
