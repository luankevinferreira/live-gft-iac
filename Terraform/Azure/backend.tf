
terraform {
  backend "azurerm" {
    resource_group_name  = "__resource_group__"
    storage_account_name = "__storage_account__"
    container_name       = "__storage_container__"
    key                  = "__key__"
  }
}