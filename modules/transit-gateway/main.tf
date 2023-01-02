#data "aws_organizations_organization" "org" {}
data "aws_ram_resource_share" "rrs" {
  name           = var.resource_share_name
  resource_owner = "SELF"
}


resource "aws_ec2_transit_gateway" "atg" {
  for_each = var.transit_gateway


  description                     = each.value.description
  transit_gateway_cidr_blocks     = compact(split(",", lookup(each.value, "transit_gateway_cidr_blocks", "")))
  default_route_table_association = lookup(each.value, "enable_default_route_table_association", "disable")
  default_route_table_propagation = lookup(each.value, "enable_default_route_table_propagation", "disable")
  auto_accept_shared_attachments  = lookup(each.value, "enable_auto_accept_shared_attachments", "disable")
  tags = {
    Name = each.key
  }

}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgv" {
  for_each = var.transit_gateway

  subnet_ids                                      = var.subnet_id
  transit_gateway_id                              = aws_ec2_transit_gateway.atg[each.key].id
  transit_gateway_default_route_table_association = lookup(each.value, "transit_gateway_default_route_table_association", false)
  transit_gateway_default_route_table_propagation = lookup(each.value, "transit_gateway_default_route_table_propagation", false)
  vpc_id                                          = var.vpc_id

  depends_on = [
    aws_ec2_transit_gateway.atg
  ]
}

resource "aws_ec2_transit_gateway_route_table" "trt" {
  for_each = var.transit_gateway

  transit_gateway_id = aws_ec2_transit_gateway.atg[each.key].id

  depends_on = [
    aws_ec2_transit_gateway.atg
  ]
}

resource "aws_ec2_transit_gateway_route" "tgr" {
  for_each = var.transit_gateway

  destination_cidr_block         = each.value.destination_cidr_block
  blackhole                      = lookup(each.value, "blackhole", null)
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgv[each.key].id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.trt[each.key].id

  depends_on = [
    aws_ec2_transit_gateway.atg
  ]
}

resource "aws_ec2_transit_gateway_route_table_association" "tgta" {
  for_each = var.transit_gateway

  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgv[each.key].id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.trt[each.key].id

  depends_on = [
    aws_ec2_transit_gateway.atg, aws_ec2_transit_gateway_vpc_attachment.tgv, aws_ec2_transit_gateway_route_table.trt
  ]
}

resource "aws_ec2_transit_gateway_route_table_propagation" "tgtp" {
  for_each = var.transit_gateway

  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgv[each.key].id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.trt[each.key].id

  depends_on = [
    aws_ec2_transit_gateway.atg, aws_ec2_transit_gateway_route_table_association.tgta, aws_ec2_transit_gateway_route_table.trt
  ]
}

resource "aws_ram_resource_association" "rra" {
  for_each = var.transit_gateway

  resource_arn       = aws_ec2_transit_gateway.atg[each.key].arn
  resource_share_arn = data.aws_ram_resource_share.rrs.arn

  depends_on = [
    aws_ec2_transit_gateway.atg, data.aws_ram_resource_share.rrs
  ]
}

/* resource "aws_ram_principal_association" "rpa" {
  for_each = var.transit_gateway

  principal          = data.aws_organizations_organization.org.arn
  resource_share_arn = aws_ram_resource_share.rrs[each.key].arn
}

resource "aws_ram_resource_share_accepter" "receiver_accept" {
  for_each = var.transit_gateway

  share_arn = aws_ram_principal_association.rpa[each.key].resource_share_arn
} */
