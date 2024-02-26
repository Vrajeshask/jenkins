terraform {
  backend "azurerm" {
    resource_group_name   = "ncpl-terraform"
    storage_account_name  = "ncplstorage"
    container_name        = "container"
    key                   = "jenkins.tfstate"
  }
}