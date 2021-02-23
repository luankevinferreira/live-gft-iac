#############################################################################
# VARIABLES
#############################################################################


variable "location" {
  type    = string
  default = "__location__"
}


#############################################################################
# PROVIDERS
#############################################################################

provider "azurerm" {
  version = "~> 1.0"
}

#############################################################################
# RESOURCES
#############################################################################

resource "azurerm_resource_group" "dev" {
  name     = "__resource_group__-__environment__"
  location = var.location
}


resource "azurerm_app_service_plan" "appserviceplan" {
  name                = "__appserviceplanName__-__environment__"
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "appservice" {
  name                = "${var.prefix}-appservice-${var.environment}"
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name
  app_service_plan_id = azurerm_app_service_plan.appserviceplan.id

  site_config {
    dotnet_framework_version = "v4.0"
  }
}

resource "azurerm_app_service_slot" "appservice" {
  name                = "${var.prefix}-stage-${var.environment}"
  app_service_name    = azurerm_app_service.appservice.name
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name
  app_service_plan_id = azurerm_app_service_plan.appserviceplan.id

  site_config {
    dotnet_framework_version = "v4.0"
  }

}
#############################################################################
# OUTPUTS
#############################################################################

output "resource_group_name" {
  value = azurerm_resource_group.dev.name
}

output "azurerm_app_service" {
  value = "${azurerm_app_service.appservice.name}"
}

output "app_service_default_hostname" {
  value = "https://${azurerm_app_service.appservice.default_site_hostname}"
}


