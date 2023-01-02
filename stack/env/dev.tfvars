resource_share_name      = "share-dev-new"
nat_gateway_enabled      = true
allow_external_principal = true
vpc_name                 = "vpc-dev"
cidr_block               = "10.0.0.0/16"
subnets_public = {
  "subnet-dev-public" = {
    subnet_cidr_block            = "10.0.0.0/24"
    internet_gateway_name        = "public-internet-gtw"
    route_table_name             = "pub-route-table"
    public_internet_gateway_name = "internet-gtw-pub"
    elastic_ip_name              = "eip-public"
    nat_gateway_name             = "nat-public"
    availability_zone            = "us-east-2b"
  }
}
subnets_private = {
  "subnet-dev-backend" = {
    subnet_cidr_block        = "10.0.1.0/24"
    private_nat_gateway_name = "nat-private"
    availability_zone        = "us-east-2b"
  },
  "subnet-dev-databaee" = {
    subnet_cidr_block        = "10.0.2.0/24"
    private_nat_gateway_name = "nat-private"
    availability_zone        = "us-east-2c"
  }
}
subnet_group_name = "sub"
nsg = {
  "security" = {
    ingress = [{
      from_port = 443
      to_port   = 443
      protocol  = "tcp"
      self      = true
    }]
    egress = [{
      from_port = 0
      to_port   = 0
      protocol  = "-1"
      self      = true
    }]
  }
}
route_table = {
  "route" = {
    cidr_block = "10.0.0.0/24"
  }
}

transit_gateway = {
  transitgw = {
    description                    = "testando-transit"
    auto_accept_shared_attachments = "enable"
    destination_cidr_block         = "10.0.0.0/24"
  }
}

vpn_gateway = {
  "vpn" = {
    bgp_asn                  = "65000"
    ip_address               = "172.0.0.1"
    type                     = "ipsec.1"
    connection_type          = "ipsec.1"
    connection_static_routes = true
  }
}
