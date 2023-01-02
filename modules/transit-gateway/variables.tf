variable "transit_gateway" {
  type = any
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = set(string)
}

variable "resource_share_name" {
  type = string
}