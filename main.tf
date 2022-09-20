resource "azurerm_resource_group" "rg1" {
    name = var.resource_group_name
    location = var.location
    tags = {
    environment = "test"
  }
}

resource "azurerm_resource_group" "rg2" {
    name = var.resource_group_name2
    location = azurerm_resource_group.rg1.location
    tags = {
    environment = "test"
  }
}

resource "azurerm_resource_group" "rg3" {
    name = "rg13"
    location = azurerm_resource_group.rg1.location
    tags = {
    environment = "test"
  }
}


resource "azurerm_storage_account" "storage" {
    name = var.azurerm_storage_account
    resource_group_name = azurerm_resource_group.rg1.name
    location = azurerm_resource_group.rg1.location
    account_tier             = "Standard"
    account_replication_type = "GRS"
  tags = {
    environment = "test"
  }
}

resource "azurerm_virtual_network" "vnet1" {
  name = var.azurerm_virtual_network
  resource_group_name = azurerm_resource_group.rg1.name
  location = azurerm_resource_group.rg1.location
  address_space       = ["10.5.0.0/16"]
  dns_servers         = ["10.5.0.4", "10.5.0.5"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.5.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.5.2.0/24"
  }

  tags = {
    environment = "test"
  }
  
}


resource "azurerm_resource_group" "rg20" {
    name = "resource-group1"
    location = "West US 3"
    tags     = {
      "env"   = "test"
      "owner" = "jeetendra"
    }
}

resource "azurerm_app_service" "app1" {
  name = "dev-we-app-01"
  resource_group_name = "resource-group1"
  location = "West Europe"
  app_service_plan_id = "/subscriptions/7d39443c-83f2-4876-94cf-cd0f084c22ca/resourceGroups/resource-group1/providers/Microsoft.Web/serverfarms/dev-we-app-winplan-01"
}