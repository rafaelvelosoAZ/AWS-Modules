resource "aws_ram_resource_share" "rrs" {
  name                      = var.resource_share_name
  allow_external_principals = var.allow_external_principal
}

resource "aws_db_subnet_group" "sng" {

  name       = var.subnet_group_name
  subnet_ids = [module.vpc.subnet_private["subnet-dev-backend"], module.vpc.subnet_private["subnet-dev-databaee"]]

  depends_on = [
    module.vpc
  ]
}

module "vpc" {
  source = "../../modules/vpc"

  resource_share_name = aws_ram_resource_share.rrs.name
  vpc_name            = var.vpc_name
  cidr_block          = var.cidr_block
  instance_tenancy    = var.instance_tenancy
  subnets_public      = var.subnets_public
  subnets_private     = var.subnets_private
  nat_gateway_enabled = var.nat_gateway_enabled

  depends_on = [
    aws_ram_resource_share.rrs
  ]
}

module "security-groups" {
  source = "../../modules/security-group"

  nsg    = var.nsg
  vpc_id = module.vpc.vpc_id
  depends_on = [
    module.vpc
  ]
}

module "route-table" {
  source      = "../../modules/route-table"
  route_table = var.route_table
  vpc_id      = module.vpc.vpc_id

  depends_on = [module.vpc, aws_ram_resource_share.rrs]
}

module "transit-gw" {
  source = "../../modules/transit-gateway"

  transit_gateway     = var.transit_gateway
  resource_share_name = aws_ram_resource_share.rrs.name
  vpc_id              = module.vpc.vpc_id
  subnet_id           = [module.vpc.subnet_public["subnet-dev-public"]]
  depends_on = [
    module.vpc, module.route-table, aws_ram_resource_share.rrs
  ]
}

module "vpn" {
  source = "../../modules/vpn"

  vpc_id      = module.vpc.vpc_id
  vpn_gateway = var.vpn_gateway

}

