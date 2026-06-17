# These variables ARE the module's interface — its "function signature".
# A caller fills these in; nothing inside the module is hard-coded.

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group this stack lives in."
}

variable "location" {
  type        = string
  description = "Azure region, e.g. \"East US\"."
}

variable "vnet_name" {
  type        = string
  description = "Name of the virtual network."
}

variable "address_space" {
  type        = list(string)
  description = "VNet address space, e.g. [\"10.10.0.0/16\"]."
}

variable "subnets" {
  type        = map(string)
  description = "Map of subnet name => CIDR prefix. e.g. { snet-app = \"10.10.1.0/24\" }"
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to every resource the module creates."
  default     = {}
}
