variable "resource_group" {
  
}

variable "vnetname" {
  
}

variable "location" {
  
}

variable "vnetcidr" {
  
}

variable "numbercount" {
    type 	  = number
    default = 3
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

      bastion_subnet = {
        name = "AzureBastionSubnet"
        address_prefixs = ["10.0.250.0/24"]
      }
    }
}

variable "bastionhost_name" {
  type = string
  default = "ThreeTierBastion"
}