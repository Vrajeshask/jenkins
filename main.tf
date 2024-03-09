provider "azurerm" {
  features {}
  subscription_id = "7aef6c4c-cd91-46ec-ad02-1e4ca07b28d4"
  client_id       = "86330ecf-fef9-4cd7-bf84-c0d712aa44d5"
  client_secret   = "62538497-197c-4c03-9a01-fb36e08f8726"
  tenant_id       = "13dc7446-cd31-4979-b778-27a010ba78ab"
}

variable "prefix" {
  default = "ncpl"
}

resource "azurerm_resource_group" "ncpl-rg" {
  name     = "${var.prefix}-resources"
  location = "West Europe"
}
