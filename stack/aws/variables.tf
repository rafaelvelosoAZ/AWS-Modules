variable "subnets_public" {
  type = any
}

variable "subnets_private" {
  type = any
}

variable "nat_gateway_enabled" {
  type = bool
}

variable "subnet_group_name" {
  type = any
}

variable "nsg" {
  type = any
}

variable "vpc_name" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "instance_tenancy" {
  type    = string
  default = null
}

variable "route_table" {
  type = any
}

variable "resource_share_name" {
  type = string
}

variable "allow_external_principal" {
  type = bool
}

variable "vpn_gateway" {
  type = any
}

variable "transit_gateway" {
  type = any
}
