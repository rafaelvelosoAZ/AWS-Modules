# AWS Security Groups
This module will prepare an AWS Security Groups:

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_nsg"></a> [nsg](#input\_nsg) | (Opcional) Criação de 1 ou mais Security Groups e 1 ou mais regras de Ingress e Egress | `any` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.asg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

# Examples module call

### Create a Security Group with Ingress and Egresss rules:

``` hcl
module "security-groups" {
  source = "../../modules/security-group"

  nsg    = var.nsg
  vpc_id = module.vpc.vpc_id
  depends_on = [
    module.vpc
  ]
}
```
The snippet above show us how to create a Security Group, take a look on the directory to understand all the possibilities.

To avoid any problem during the run don´t forget to put all the variables needed on your stack directory.

# Examples TFvars call

``` hcl
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

