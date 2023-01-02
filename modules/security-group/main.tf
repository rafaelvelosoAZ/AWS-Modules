data "aws_vpc" "vpc" {
  id = var.vpc_id
}


resource "aws_security_group" "asg" {
  for_each = var.nsg

  name   = each.key
  vpc_id = data.aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = lookup(each.value, "ingress", {})

    content {
      description      = lookup(ingress.value, "description", null)
      from_port        = ingress.value.from_port
      to_port          = ingress.value.to_port
      protocol         = ingress.value.protocol
      self             = ingress.value.self
      cidr_blocks      = compact(split(",", lookup(ingress.value, "cidr_blocks", "")))
      ipv6_cidr_blocks = compact(split(",", lookup(ingress.value, "ipv6_cidr_blocks", "")))
    }
  }
  dynamic "egress" {
    for_each = lookup(each.value, "egress", {})

    content {
      from_port        = egress.value.from_port
      to_port          = egress.value.to_port
      protocol         = egress.value.protocol
      self             = egress.value.self
      cidr_blocks      = compact(split(",", lookup(egress.value, "cidr_blocks", "")))
      ipv6_cidr_blocks = compact(split(",", lookup(egress.value, "ipv6_cidr_blocks", "")))
    }
  }

  tags = {
    Name = each.key
  }
}
