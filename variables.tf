variable "resource_group_name" {
  type        = string
  description = "The name of the Azure Resource Group"
}

variable "resource_group_location" {
  type        = string
  description = "The location of the Azure Resource Group"
}

variable "client_id" {
    type = string
    description = "client id"
}

variable "client_secret" {
    type = string
    description = "client secret key"
}