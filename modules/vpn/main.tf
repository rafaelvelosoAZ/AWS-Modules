data "aws_vpc" "vpc" {
  id = var.vpc_id
}

resource "aws_vpn_gateway" "vpn_gateway" {
  for_each = var.vpn_gateway
  vpc_id   = data.aws_vpc.vpc.id

  tags = {
    Name = each.key
  }
}

resource "aws_customer_gateway" "customer_gateway" {
  for_each   = var.vpn_gateway
  bgp_asn    = each.value.bgp_asn
  ip_address = each.value.ip_address
  type       = each.value.type
}

resource "aws_vpn_connection" "main" {
  for_each = var.vpn_gateway

  vpn_gateway_id      = aws_vpn_gateway.vpn_gateway[each.key].id
  customer_gateway_id = aws_customer_gateway.customer_gateway[each.key].id
  type                = each.value.connection_type
  static_routes_only  = each.value.connection_static_routes
}

resource "aws_vpn_gateway_attachment" "vpn_attachment" {
  for_each = var.vpn_gateway

  vpc_id         = data.aws_vpc.vpc.id
  vpn_gateway_id = aws_vpn_gateway.vpn_gateway[each.key].id
}
