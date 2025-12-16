resource "azurerm_virtual_network" "hub-vnet" {
  name                = "${local.fleet_name}-vnet"
  location            = azurerm_resource_group.fleet_rg.location
  resource_group_name = azurerm_resource_group.fleet_rg.name
  address_space       = ["10.224.0.0/12"]
}

resource "azurerm_subnet" "hub-cluster-subnet" {
  name                 = "fleet-hub-cluster-subnet"
  resource_group_name  = azurerm_resource_group.fleet_rg.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = ["10.224.0.0/15"]
  private_endpoint_network_policies = "Disabled"
  private_link_service_network_policies_enabled = true
}

resource "azurerm_subnet" "fleet-hub-apiserver-subnet" {
  name                 = "fleet-hub-apiserver-subnet"
  resource_group_name  = azurerm_resource_group.fleet_rg.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = ["10.226.0.0/15"]
  delegation {
    name = "aksApiServerSubnetDelegation"
    service_delegation {
      name    = "Microsoft.ContainerService/managedClusters"
    }
  }
}

# resource "azurerm_subnet" "member-cluster-01-subnet" {
#   name                 = "member-cluster-01-subnet"
#   resource_group_name  = azurerm_resource_group.hub-vnet-rg.name
#   virtual_network_name = azurerm_virtual_network.hub-vnet.name
#   address_prefixes     = ["10.228.0.0/15"]
#   private_endpoint_network_policies = "Disabled"
#   private_link_service_network_policies_enabled = true
# }

# resource "azurerm_subnet" "member-cluster-01-apiserver" {
#   name                 = "member-cluster-01-apiserver"
#   resource_group_name  = azurerm_resource_group.hub-vnet-rg.name
#   virtual_network_name = azurerm_virtual_network.hub-vnet.name
#   address_prefixes     = ["10.230.0.0/15"]
#   delegation {
#     name = "aksApiServerSubnetDelegation"
#     service_delegation {
#       name    = "Microsoft.ContainerService/managedClusters"
#     }
#   }
# }

# resource "azurerm_subnet" "member-cluster-02-subnet" {
#   name                 = "member-cluster-02-subnet"
#   resource_group_name  = azurerm_resource_group.hub-vnet-rg.name
#   virtual_network_name = azurerm_virtual_network.hub-vnet.name
#   address_prefixes     = ["10.232.0.0/15"]
#   private_endpoint_network_policies = "Disabled"
#   private_link_service_network_policies_enabled = true
# }

# resource "azurerm_subnet" "member-cluster-02-apiserver" {
#   name                 = "member-cluster-02-apiserver"
#   resource_group_name  = azurerm_resource_group.hub-vnet-rg.name
#   virtual_network_name = azurerm_virtual_network.hub-vnet.name
#   address_prefixes     = ["10.234.0.0/15"]
#   delegation {
#     name = "aksApiServerSubnetDelegation"
#     service_delegation {
#       name    = "Microsoft.ContainerService/managedClusters"
#     }
#   }
# }