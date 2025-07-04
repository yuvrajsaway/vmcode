
resource "azurerm_linux_virtual_machine" "virtaul_machine" {
  name                            = var.virtual_machine_name
  resource_group_name             = data.azurerm_resource_group.resource_group.name
  location                        = data.azurerm_resource_group.resource_group.location
  size                            = "Standard_F2"
  admin_username                  = data.azurerm_key_vault_secret.username.value
  admin_password                  = data.azurerm_key_vault_secret.password.value
  disable_password_authentication = false
  network_interface_ids           = var.network_interface_ids


 

  #   admin_ssh_key {
  #     username   = "adminuser"
  #     public_key = file("~/.ssh/id_rsa.pub")
  #   }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  custom_data = base64encode(<<EOF
#!/bin/bash
apt-get update
apt-get install -y nginx
systemctl enable nginx
systemctl start nginx
EOF
  )
}

data "azurerm_resource_group" "resource_group" {
  name = var.resource_group_name
}


data "azurerm_key_vault_secret" "username" {
  name         = "vmusername"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "password" {
  name         = "vmpassword"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}


data "azurerm_key_vault" "keyvault" {
  name                = var.keyvault
  resource_group_name = var.resource_group_name
}