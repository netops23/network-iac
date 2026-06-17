terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}

  # azurerm 4.x requires a subscription_id. The cleanest way for a local lab
  # is to export it from your current `az login` context before running:
  #
  #   export ARM_SUBSCRIPTION_ID=$(az account show --query id -o tsv)
  #
  # (On PowerShell:  $env:ARM_SUBSCRIPTION_ID = (az account show --query id -o tsv))
}
