# Custom Named Subnets

Example demonstrates setting fully custom names a variety of subnets.

Example shows using Default Tags in the provider as well as passing additional tags into the resource.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Examples

```hcl
provider "aws" {
  default_tags {
    tags = {
      environment = "dev"
      terraform   = "true"
    }
  }
}

variable "cidr_block" {
  default = "10.20.32.0/20"
}

variable "tags" {
  default = {
    example = "true"
  }
}
module "vpc" {

  source  = "so1omon563/vpc/aws"
  version = "2.2.0"

  vpc = {
    cidr_block = var.cidr_block
  }
  public_cidrs  = []
  private_cidrs = []

  name = "example-custom-subnets-vpc"

  tags = var.tags
}

output "vpc" {
  value = module.vpc
}

## Create custom named public subnets.

module "custom-network" {
  source  = "so1omon563/vpc/aws//modules/subnets"
  version = "2.2.0"

  vpc_id = module.vpc.vpc_id

  subnet_name_overrides = [
    "custom-1",
    "custom-2"
  ]
  route_table_name_override = "custom-routes"
  tags                      = var.tags

  ipv4_cidr_blocks = cidrsubnets(cidrsubnet(var.cidr_block, 7, 8), 1, 1)

  map_public_ip_on_launch = true
}

output "custom-network" {
  value = module.custom-network
}

# Since we created a VPC without any default Public subnets, we need to create an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = module.vpc.vpc_id
  tags   = merge(var.tags, { Name = "custom-igw" })
}

# Need to add a route to the custom network to the public route table
resource "aws_route" "ipv4_default" {
  depends_on     = [aws_internet_gateway.igw]
  count          = length(module.custom-network.route_table_ids)
  route_table_id = module.custom-network.route_table_ids[count.index]
  gateway_id     = aws_internet_gateway.igw.id

  destination_cidr_block = "0.0.0.0/0"
}
```

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.35.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_custom-network"></a> [custom-network](#module\_custom-network) | so1omon563/vpc/aws//modules/subnets | 2.2.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | so1omon563/vpc/aws | 2.2.0 |

## Resources

| Name | Type |
|------|------|
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_route.ipv4_default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | n/a | `string` | `"10.20.32.0/20"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map` | <pre>{<br>  "example": "true"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_custom-network"></a> [custom-network](#output\_custom-network) | n/a |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
