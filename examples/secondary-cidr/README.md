# Secondary CIDR Block

Example demonstrates adding a secondary CIDR block to a VPC, and then creating subnets within that CIDR block.

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

module "vpc" {
  source  = "so1omon563/vpc/aws"
  version = "2.2.0"

  name = "example-secondary-cidr-vpc"
  tags = {
    example = "true"
  }
}

# Create the additional CIDR block
module "secondary_cidr" {
  source  = "so1omon563/vpc/aws//modules/additional-cidr-block-association"
  version = "2.2.0"

  vpc_id     = module.vpc.vpc_id
  cidr_block = "10.0.0.0/16"
}

# Create subnets for Lambda in the new CIDR block
module "lambda_subnets" {
  source  = "so1omon563/vpc/aws//modules/subnets"
  version = "2.2.0"

  vpc_id      = module.vpc.vpc_id
  name        = module.vpc.name_prefix
  subnet_type = "lambda"
  tags        = module.vpc.tags

  ipv4_cidr_blocks = cidrsubnets(module.secondary_cidr.cidr_block_association.cidr_block, 8, 8, 8, 8)
}

output "network" {
  value = module.vpc
}

output "secondary_cidr" {
  value = module.secondary_cidr
}

output "lambda_subnets" {
  value = module.lambda_subnets
}
```

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambda_subnets"></a> [lambda\_subnets](#module\_lambda\_subnets) | so1omon563/vpc/aws//modules/subnets | 2.2.0 |
| <a name="module_secondary_cidr"></a> [secondary\_cidr](#module\_secondary\_cidr) | so1omon563/vpc/aws//modules/additional-cidr-block-association | 2.2.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | so1omon563/vpc/aws | 2.2.0 |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_subnets"></a> [lambda\_subnets](#output\_lambda\_subnets) | n/a |
| <a name="output_network"></a> [network](#output\_network) | n/a |
| <a name="output_secondary_cidr"></a> [secondary\_cidr](#output\_secondary\_cidr) | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
