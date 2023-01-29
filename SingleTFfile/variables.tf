variable "name" {
    default = "TestRG2"
}

variable "location" {
    default = "eastus"
}

variable "vnetname" {
    default = "testvnet2"
}

variable "vnetcidr" {
    default = ["10.0.0.0/16"]
}

variable "subnets" {
    type = map(any)
    default = {
      "websubnet" = {
        name = "websubnet"
        address_prefixs = ["10.0.1.0/24"]
      }

      "appsubnet" = {
        name = "appsubnet"
        address_prefixs = ["10.0.2.0/24"]
      } 

      "datasubnet" = {
        name = "datasubnet"
        address_prefixs = ["10.0.3.0/24"]
      } 
    }
}

variable "nw_int_names" {
  type = list(string)
  default = ["nw-int1", "nw-int2","nw-int3"]
}

variable "vm_names" {
  type = list(string)
  default = ["vm-demo1","vm-demo2","vm-demo3"]
}

variable "nsg_rules1" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  
  }))
  
}

variable "numbercount" {
    type 	  = number
    default = 3
} 