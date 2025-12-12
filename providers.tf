terraform {
  required_version = ">= 1.0"
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~> 2.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }
}

provider "azurerm" {
    resource_provider_registrations = "none"
    subscription_id = "ADD_YOUR_SUBSCRIPTION_ID_HERE"
    features {}
}

provider "azapi" {
}