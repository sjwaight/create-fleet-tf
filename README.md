# Terraform to create Fleet with private hub cluster

Creates:

1. VNet with subnets for hub clusters and two member clusters.
1. VNet subnets ready for API VNet integration.
1. Fleet Manager's serivce principal is granted Network Contributor to API subnet.
1. Each AKS cluster is also granted access to their own subnet.

Modify [providers.tf](./providers.tf) and add your Azure Subscription (or create environment variable instead).

```json
provider "azurerm" {
    resource_provider_registrations = "none"
    subscription_id = "ADD_YOUR_SUBSCRIPTION_ID_HERE"
    features {}
}
```
