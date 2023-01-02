# AWS VPN
This module will prepare an AWS VPN:

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |
| <a name="input_vpn_gateway"></a> [vpn\_gateway](#input\_vpn\_gateway) | n/a | `any` | n/a | yes |

## Resources

| Name | Type |
|------|------|
| [aws_customer_gateway.customer_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/customer_gateway) | resource |
| [aws_vpn_connection.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_connection) | resource |
| [aws_vpn_gateway.vpn_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_gateway) | resource |
| [aws_vpn_gateway_attachment.vpn_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_gateway_attachment) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

# Examples module call

### Create a VPN Customer Gateway, VPN Gateway and a Connection:

``` hcl
module "vpn" {
  source = "../../modules/vpn"

  vpc_id      = module.vpc.vpc_id
  vpn_gateway = var.vpn_gateway

}
```
The snippet above show us how to create a module vpc with a Public and Private subnets and much more, take a look on the directory to understand all the possibilities.

To avoid any problem during the run don´t forget to put all the variables needed on your stack directory.

# Examples TFvars call

``` hcl
vpn_gateway = {
  "vpn" = {
    bgp_asn                  = "65000"
    ip_address               = "172.0.0.1"
    type                     = "ipsec.1"
    connection_type          = "ipsec.1"
    connection_static_routes = true
  }
}
```

## How to create a documentation for the environent
To create a README file simply use the command:
``` shell
make prepare-readme
```

## Wish to contribute?

You must install [**terraform-docs**](https://terraform-docs.io/user-guide/installation/).
Steps:
* Clone this reop;
* Create a branch;
* Make all modifications you want;
* Create a documentation `make prepare-readme`;
* Commit your changes;
* Create a tag (v1.1.0, v1.2.3, etc), push your branch and raise a Pull Request.

<sub>For any questions simply reach me: [carlos.oliveira@softwareone.com](mailto:carlos.oliveira@softwareone.com)</sub>

