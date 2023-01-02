data "aws_ram_resource_share" "rrs" {
  name           = var.resource_share_name
  resource_owner = "SELF"
}

resource "aws_vpc" "vpc" {

  cidr_block       = var.cidr_block
  instance_tenancy = var.instance_tenancy

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public" {
  for_each = var.subnets_public == null ? {} : var.subnets_public

  vpc_id               = aws_vpc.vpc.id
  cidr_block           = each.value.subnet_cidr_block
  availability_zone    = lookup(each.value, "availability_zone", "")
  /* availability_zone_id = lookup(each.value, "availability_zone_id", "") */
  tags = {
    Name = each.key
  }
  depends_on = [
    aws_vpc.vpc, aws_internet_gateway.aig
  ]
}

resource "aws_internet_gateway" "aig" {
  for_each = var.subnets_public == null ? {} : var.subnets_public

  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = each.value.internet_gateway_name
  }
}

resource "aws_route_table" "public" {
  for_each = var.subnets_public == null ? {} : var.subnets_public

  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = each.value.route_table_name
  }
}

resource "aws_route" "public_internet_gateway" {
  for_each = var.subnets_public == null ? {} : var.subnets_public

  route_table_id         = aws_route_table.public[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.aig[each.key].id
}

resource "aws_eip" "eip" {
  for_each = var.subnets_public == null ? {} : var.subnets_public
  vpc      = true
  tags = {
    Name = each.value.elastic_ip_name
  }
  depends_on = [
    aws_internet_gateway.aig
  ]
}

resource "aws_nat_gateway" "nat" {
  for_each = var.subnets_public == null ? {} : var.subnets_public

  allocation_id = aws_eip.eip[each.key].id
  subnet_id     = aws_subnet.public[each.key].id
  tags = {
    Name = each.value.nat_gateway_name
  }
}

resource "aws_route_table_association" "public" {
  for_each = var.subnets_public == null ? {} : var.subnets_public

  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public[each.key].id
}

resource "aws_subnet" "private" {
  for_each = var.subnets_private == null ? {} : var.subnets_private

  vpc_id               = aws_vpc.vpc.id
  cidr_block           = each.value.subnet_cidr_block
  availability_zone    = lookup(each.value, "availability_zone", "")
  /* availability_zone_id = lookup(each.value, "availability_zone_id", "") */
  tags = {
    Name = each.key
  }
  depends_on = [
    aws_vpc.vpc
  ]
}

resource "aws_nat_gateway" "private_nat" {
  #for_each = var.subnets_private == null ? {} : var.subnets_private
  for_each = { for k, v in var.subnets_private : k => v if var.nat_gateway_enabled == true }

  connectivity_type = "private"
  subnet_id         = aws_subnet.private[each.key].id
  tags = {
    Name = each.value.private_nat_gateway_name
  }
}
