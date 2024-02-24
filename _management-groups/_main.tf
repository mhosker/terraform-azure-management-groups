# *********************************************************
# TERRAFORM CONFIG
# *********************************************************

# ---------------------------------------------------------
# Providers
# ---------------------------------------------------------

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
  required_version = ">= 1.3.8"
}

# ---------------------------------------------------------
# Tenant Details
# ---------------------------------------------------------

data "azurerm_client_config" "current" {}