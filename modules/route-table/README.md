# AWS Route Table
This module will prepare a Route Table:

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_route_table"></a> [route\_table](#input\_route\_table) | n/a | `any` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |

## Resources

| Name | Type |
|------|------|
| [aws_route_table.rtb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

# Examples module call

### Create a Route tables and Routes:

``` hcl
module "route-table" {
  source      = "../../modules/route-table"
  route_table = var.route_table
  vpc_id      = module.vpc.vpc_id

  depends_on = [module.vpc, aws_ram_resource_share.rrs]
}
```

The snippet above show us how to create a Route table and Routes, take a look on the directory to understand all the possibilities.

To avoid any problem during the run don´t forget to put all the variables needed on your stack directory.

# Examples TFvars call
``` hcl
route_table = {
  "route" = {
    cidr_block = "10.0.0.0/24"
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

