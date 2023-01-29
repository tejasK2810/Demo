variable "name" {
  
}

variable "location" {
  
}

variable "vnetname" {
  
}

variable "vnetcidr" {
  
}

variable "subnets" {
  
}

variable "database_name" {
  
}


variable "database_version" {
  
}

variable "database_admin" {
  
}

variable "database_password" {
    sensitive = true
}

variable "vm_names" {
  type = list(string)
  default = ["vm-demo1","vm-demo2","vm-demo3"]
}

variable "nw_int_names" {
  type = list(string)
  default = ["nw-int1", "nw-int2","nw-int3"]
}


variable "numbercount" {
    type 	  = number
    default = 3
} 

variable "subnets1" {
  type = any
  default = []
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
