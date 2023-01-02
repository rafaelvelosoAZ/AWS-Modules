variable "nsg" {
  type        = any
  description = "(Opcional) Criação de 1 ou mais Security Groups e 1 ou mais regras de Ingress e Egress"
}

variable "vpc_id" {
  type = string
}
