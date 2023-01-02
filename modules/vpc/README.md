# AWS VPC
This module will prepare an AWS VPC:

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | (Opcional) O bloco CIDR IPv4 para a VPC. O CIDR pode ser definido explicitamente ou pode ser derivado do IPAM usando ipv4\_netmask\_length. | `string` | n/a | yes |
| <a name="input_instance_tenancy"></a> [instance\_tenancy](#input\_instance\_tenancy) | (Opcional) Uma opção de locação para instâncias executadas na VPC. O padrão é default, o que torna suas instâncias compartilhadas no host. Usar qualquer uma das outras opções ( dedicatedou host) custa pelo menos US$ 2/h. | `string` | n/a | yes |
| <a name="input_resource_share_name"></a> [resource\_share\_name](#input\_resource\_share\_name) | n/a | `string` | n/a | yes |
| <a name="input_subnets_private"></a> [subnets\_private](#input\_subnets\_private) | (Obrigatório) Criação de 1 ou mais subnets, são necessárias definições de nome de cidr\_block | `any` | n/a | yes |
| <a name="input_subnets_public"></a> [subnets\_public](#input\_subnets\_public) | (Obrigatório) Criação de 1 ou mais subnets, são necessárias definições de nome de cidr\_block | `any` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | (Obrigatorio )Definição do nome da VPC criada, apenas 1 vpc por módulo | `string` | n/a | yes |

## Resources

| Name | Type |
|------|------|
| [aws_egress_only_internet_gateway.oig](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/egress_only_internet_gateway) | resource |
| [aws_eip.eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.aig](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_nat_gateway.private_nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.public_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_ram_resource_share.rrs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ram_resource_share) | data source |


# Examples module call

### Create a VPC with public subnets and private subnets, integrating with route tables and routes:

``` hcl

resource "aws_ram_resource_share" "rrs" {
  name                      = var.resource_share_name
  allow_external_principals = var.allow_external_principal
}

module "vpc" {
  source = "../../modules/vpc"

  resource_share_name = aws_ram_resource_share.rrs.name
  vpc_name            = var.vpc_name
  cidr_block          = var.cidr_block
  instance_tenancy    = var.instance_tenancy
  subnets_public      = var.subnets_public
  subnets_private     = var.subnets_private

  depends_on = [
    aws_ram_resource_share.rrs
  ]
}

```
The snippet above show us how to create a module vpc with a Public and Private subnets and much more, take a look on the directory to understand all the possibilities.

To avoid any problem during the run don´t forget to put all the variables needed on your stack directory.

# Examples TFvars call

``` hcl
resource_share_name      = "share-dev-new"
vpc_name                 = "vpc-dev"
cidr_block               = "10.0.0.0/16"
instance_tenancy         = "default"
subnets_public = {
  "subnet-dev-public" = {
    subnet_cidr_block                 = "10.0.0.0/24"
    internet_gateway_name             = "public-internet-gtw"
    egress_only_internet_gateway_name = "public"
    route_table_name                  = "pub-route-table"
    public_internet_gateway_name      = "internet-gtw-pub"
    elastic_ip_name                   = "eip-public"
    nat_gateway_name                  = "nat-public"
  }
}
subnets_private = {
  "subnet-dev-private" = {
    subnet_cidr_block        = "10.0.1.0/24"
    private_nat_gateway_name = "nat-private"
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

