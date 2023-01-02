variable "vpc_name" {
  type        = string
  description = "(Obrigatorio )Definição do nome da VPC criada, apenas 1 vpc por módulo"
}

variable "nat_gateway_enabled" {
  type = bool
}

variable "cidr_block" {
  type        = string
  description = "(Opcional) O bloco CIDR IPv4 para a VPC. O CIDR pode ser definido explicitamente ou pode ser derivado do IPAM usando ipv4_netmask_length."
}

variable "instance_tenancy" {
  type        = string
  description = "(Opcional) Uma opção de locação para instâncias executadas na VPC. O padrão é default, o que torna suas instâncias compartilhadas no host. Usar qualquer uma das outras opções ( dedicatedou host) custa pelo menos US$ 2/h."
  default     = null
}

variable "subnets_public" {
  type        = any
  description = "(Obrigatório) Criação de 1 ou mais subnets, são necessárias definições de nome de cidr_block"
}

variable "subnets_private" {
  type        = any
  description = "(Obrigatório) Criação de 1 ou mais subnets, são necessárias definições de nome de cidr_block"
}

variable "resource_share_name" {
  type = string
}

/* variable "private_nat_gateway" {
  type = bool
} */
