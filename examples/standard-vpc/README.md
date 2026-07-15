# Standard VPC

Example demonstrates creating a VPC using only default values, and Gateway Endpoints for S3 and DynamoDB.

Example shows using Default Tags in the provider as well as passing additional tags into the resource.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Examples

```hcl
terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0, < 6.0"
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

module "vpc" {
  source  = "so1omon563/vpc/aws"
  version = "2.2.0"

  name = "example-standard-vpc"
  tags = {
    example = "true"
  }
}

module "endpoints" {
  source  = "so1omon563/vpc/aws//modules/gateway-endpoints/by-route-table"
  version = "2.2.0"

  name = module.vpc.name_prefix
  tags = module.vpc.tags

  s3_route_table_ids       = module.vpc.private_route_table_ids[*]
  dynamodb_route_table_ids = module.vpc.private_route_table_ids[*]
}

output "network" {
  value = module.vpc
}

output "endpoints" {
  value = module.endpoints
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0, < 6.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_endpoints"></a> [endpoints](#module\_endpoints) | so1omon563/vpc/aws//modules/gateway-endpoints/by-route-table | 2.2.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | so1omon563/vpc/aws | 2.2.0 |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoints"></a> [endpoints](#output\_endpoints) | n/a |
| <a name="output_network"></a> [network](#output\_network) | n/a |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
