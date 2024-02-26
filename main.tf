provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "ncpl-rg" {
  name     = "ncpl-rg"
  location = "East US"  # Change to your desired region
}

resource "azurerm_virtual_network" "ncpl-vn" {
  name                = "ncpl-vn"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.ncpl-rg.location
  resource_group_name = azurerm_resource_group.ncpl-rg.name
}

resource "azurerm_subnet" "ncpl-subnet" {
  name                 = "ncpl-subnet"
  resource_group_name  = azurerm_resource_group.ncpl-rg.name
  virtual_network_name = azurerm_virtual_network.ncpl-vn.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "nic" {
  count               = 2
  name                = "ncpl-nic-${count.index}"
  location            = azurerm_resource_group.ncpl-rg.location
  resource_group_name = azurerm_resource_group.ncpl-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.ncpl-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "ncpm-vm" {
  count                = 2
  name                 = "ncpl-vm-${count.index}"
  location             = azurerm_resource_group.ncpl-rg.location
  resource_group_name  = azurerm_resource_group.ncpl-rg.name
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]
  size                 = "Standard_B1ls"  # Minimum size VM
  admin_username       = "adminuser"
  admin_password       = "P@ssw0rd1234!"  # Change to your desired password
  computer_name        = "hostname-${count.index}"
  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
