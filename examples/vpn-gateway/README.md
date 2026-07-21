# VPN gateway

Example demonstrates a VPN Gateway in a VPC.

Example shows using Default Tags in the provider as well as passing additional tags into the resource.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Examples

```hcl
terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
    }
  }
}

provider "aws" {
  default_tags {
    tags = {
      environment = "dev"
      terraform   = "true"
    }
  }
}

locals {
  cidr_block = "10.169.240.0/20"
}

module "vpc" {
  source  = "so1omon563/vpc/aws"
  version = "2.2.0"

  vpc = {
    cidr_block = local.cidr_block
  }

  public_cidrs  = cidrsubnets(local.cidr_block, 4, 4, 4)
  private_cidrs = cidrsubnets(cidrsubnet(local.cidr_block, 1, 1), 2, 2, 2)

  name = "example-vpn-vpc"

  tags = {
    example = "true"
  }
}

module "vpn" {

  source  = "so1omon563/vpc/aws//modules/vpn-gateway/by-route-table"
  version = "2.2.0"

  name = module.vpc.name_prefix
  tags = module.vpc.tags

  route_table_ids = concat(module.vpc.public_route_table_ids[*], module.vpc.private_route_table_ids[*])
}

output "network" {
  value = module.vpc
}

output "vpn" {
  value = module.vpn
}
```

## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | so1omon563/vpc/aws | 2.2.0 |
| <a name="module_vpn"></a> [vpn](#module\_vpn) | so1omon563/vpc/aws//modules/vpn-gateway/by-route-table | 2.2.0 |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_network"></a> [network](#output\_network) | n/a |
| <a name="output_vpn"></a> [vpn](#output\_vpn) | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
