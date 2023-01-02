resource "aws_ram_resource_share" "rrs" {
  for_each = var.transit_gateway

  name                      = each.value.resource_share_name
  allow_external_principals = each.value.allow_external_principals

  depends_on = [
    aws_ec2_transit_gateway.atg
  ]

}