resource "azurerm_availability_set" "name" {
    count = var.aset_names
    name = element(var.aset_names, count.index)
    location = var.location
    resource_group_name = var.resource_group
}

resource "azurerm_network_interface" "name" {
    
    count = var.nw_int_names
    name = element(var.nw_int_names, count.index)
    location = var.location
    resource_group_name = var.resource_group

    ip_configuration {
        
        name = "${element(var.nw_int_names, count.index)}-ipconfig"
        subnet_id = (var.subnets1)
        private_ip_address_allocation = "Dynamic"
        
    }
}

resource "azurerm_windows_virtual_machine" "example" {
  count = var.vm_names

  name                = element(var.vm_names, count.index)
  resource_group_name = var.resource_group
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [ azurerm_network_interface.name[count.index].id ]
  

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}