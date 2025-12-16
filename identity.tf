##
# REQUIRED: Assign Network Contributor Role to "Azure Kubernetes Service - Fleet RP" to enable hub cluster updates
##
resource "azurerm_role_assignment" "fleet_identity_01_network_contributor" {
  scope                = azurerm_subnet.hub-cluster-subnet.id
  role_definition_name = "Network Contributor"
  principal_id         = "809eb894-03e5-4d19-a1bb-484658e416f7"
  principal_type       = "ServicePrincipal"

  depends_on = [azurerm_subnet.hub-cluster-subnet]
}

##
# REQUIRED: Create User Assigned Managed Identity for Fleet Manager
##
resource "azurerm_user_assigned_identity" "fleet_user_assigned_identity" {
  location            = azurerm_resource_group.fleet_rg.location
  name                = "${local.fleet_name}-uai"
  resource_group_name = azurerm_resource_group.fleet_rg.name
}

# REQUIRED: Assign Managed Identity the Network Contributor Role scoped to Hub Cluster API Server Subnet
resource "azurerm_role_assignment" "fleet_user_assign_id_api_subnet_network_contributor" {
  scope                = azurerm_subnet.fleet-hub-apiserver-subnet.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.fleet_user_assigned_identity.principal_id
  principal_type       = "ServicePrincipal"

  depends_on = [azurerm_subnet.fleet-hub-apiserver-subnet, azurerm_user_assigned_identity.fleet_user_assigned_identity]
}

# REQUIRED: Assign Managed Identity the Network Contributor Role scoped to Hub Cluster Subnet
resource "azurerm_role_assignment" "fleet_user_assign_id_hub_subnet_network_contributor" {
  scope                = azurerm_subnet.hub-cluster-subnet.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.fleet_user_assigned_identity.principal_id
  principal_type       = "ServicePrincipal"

  depends_on = [azurerm_subnet.hub-cluster-subnet, azurerm_user_assigned_identity.fleet_user_assigned_identity]
}