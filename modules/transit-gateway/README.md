# AWS Transit Gateway
This module will prepare an AWS Transit Gateway:

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_share_name"></a> [resource\_share\_name](#input\_resource\_share\_name) | n/a | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `set(string)` | n/a | yes |
| <a name="input_transit_gateway"></a> [transit\_gateway](#input\_transit\_gateway) | n/a | `any` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |

## Resources

| Name | Type |
|------|------|
| [aws_ec2_transit_gateway.atg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway) | resource |
| [aws_ec2_transit_gateway_route.tgr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route_table.trt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table) | resource |
| [aws_ec2_transit_gateway_route_table_association.tgta](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_association) | resource |
| [aws_ec2_transit_gateway_route_table_propagation.tgtp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_propagation) | resource |
| [aws_ec2_transit_gateway_vpc_attachment.tgv](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |
| [aws_ram_resource_association.rra](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_association) | resource |
| [aws_ram_resource_share.rrs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ram_resource_share) | data source |

# Examples module call

### Create a Transit Gateway:
```hcl
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
```
The snippet above show us how to create a module vpc with a Public and Private subnets and much more, take a look on the directory to understand all the possibilities.

To avoid any problem during the run don´t forget to put all the variables needed on your stack directory.

# Examples TFvars call
```hcl
transit_gateway = {
  transitgw = {
    description                    = "testando-transit"
    auto_accept_shared_attachments = "enable"
    destination_cidr_block         = "10.0.0.0/24"
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

