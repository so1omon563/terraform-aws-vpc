# Multiple Subnets

Example demonstrates some common "slightly more secure" use cases for adding a variety of subnets with specific NACLs and endpoints.

Example shows using Default Tags in the provider as well as passing additional tags into the resource.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Examples

```hcl
locals {
  cidr_block     = "10.20.32.0/20"
  restrict_nacls = true
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
  version = "1.0.0"

  vpc = {
    cidr_block = local.cidr_block
  }
  restrict_nacls = local.restrict_nacls

  public_cidrs  = cidrsubnets(local.cidr_block, 6, 6, 6)
  private_cidrs = cidrsubnets(cidrsubnet(local.cidr_block, 1, 1), 2, 2, 2)

  name = "example-multiple-networks-vpc"

  tags = {
    example = "true"
  }
}

output "vpc" {
  value = module.vpc
}

## Create subnets and NACLs for a bastion host

module "bastion-network" {
  source  = "so1omon563/vpc/aws//modules/subnets"
  version = "1.0.0"

  vpc_id = module.vpc.vpc_id

  subnet_type = "bastion"

  name = module.vpc.name_prefix
  tags = module.vpc.tags

  ipv4_cidr_blocks = cidrsubnets(cidrsubnet(local.cidr_block, 7, 8), 1, 1)


  map_public_ip_on_launch = true
  restrict_nacls          = local.restrict_nacls
}

output "bastion-network" {
  value = module.bastion-network
}

# Need to add a route to the bastion network to the public route table
resource "aws_route" "ipv4_default" {
  count          = length(module.bastion-network.route_table_ids)
  route_table_id = module.bastion-network.route_table_ids[count.index]
  gateway_id     = module.vpc.vpc["igw_id"]

  destination_cidr_block = "0.0.0.0/0"
}

# This opens port 22 from anywhere, so be sure to use your security group to narrow the scope
module "bastion-nacl" {
  source  = "so1omon563/vpc/aws//modules/subnet-nacl-rules/generic"
  version = "1.0.0"

  nacl_id = module.bastion-network.nacl.id

  ingress_tcp_ports = [22]
}

## Create subnets and NACLs for Redis cache

module "cache-network" {
  source  = "so1omon563/vpc/aws//modules/subnets"
  version = "1.0.0"

  vpc_id = module.vpc.vpc_id

  subnet_type = "elasticache"

  name = module.vpc.name_prefix
  tags = module.vpc.tags

  ipv4_cidr_blocks = cidrsubnets(cidrsubnet(local.cidr_block, 6, 6), 2, 2, 2)

  restrict_nacls = local.restrict_nacls
}

module "redis-nacl" {
  source  = "so1omon563/vpc/aws//modules/subnet-nacl-rules/service"
  version = "1.0.0"

  nacl_id = module.cache-network.nacl.id

  ipv4_cidr_block   = local.cidr_block
  ingress_tcp_ports = [6379]
}

## Create subnets and NACLs for RDS

module "rds-network" {
  source  = "so1omon563/vpc/aws//modules/subnets"
  version = "1.0.0"

  vpc_id = module.vpc.vpc_id

  subnet_type = "rds"

  name = module.vpc.name_prefix
  tags = module.vpc.tags

  ipv4_cidr_blocks = cidrsubnets(cidrsubnet(local.cidr_block, 6, 5), 2, 2, 2)

  restrict_nacls = local.restrict_nacls

}

module "postgres-nacl" {
  source  = "so1omon563/vpc/aws//modules/subnet-nacl-rules/service"
  version = "1.0.0"

  nacl_id = module.rds-network.nacl.id

  ipv4_cidr_block   = local.cidr_block
  ingress_tcp_ports = [5432]
}

## Create generic NACLs for private and public subnets
module "private-nacl" {
  source  = "so1omon563/vpc/aws//modules/subnet-nacl-rules/generic"
  version = "1.0.0"

  nacl_id = module.vpc.private_nacl.id
}

module "public-nacl" {
  source  = "so1omon563/vpc/aws//modules/subnet-nacl-rules/generic"
  version = "1.0.0"

  nacl_id = module.vpc.public_nacl.id
}

## Create S3 and DynamoDB endpoints
module "endpoints" {
  source  = "so1omon563/vpc/aws//modules/gateway-endpoints//by-route-table"
  version = "1.0.0"

  name = module.vpc.name_prefix
  tags = module.vpc.tags

  s3_route_table_ids       = module.vpc.private_route_table_ids
  dynamodb_route_table_ids = module.vpc.private_route_table_ids
}

output "endpoints" {
  value = module.endpoints
}
```

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.35.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bastion-nacl"></a> [bastion-nacl](#module\_bastion-nacl) | so1omon563/vpc/aws//modules/subnet-nacl-rules/generic | 1.0.0 |
| <a name="module_bastion-network"></a> [bastion-network](#module\_bastion-network) | so1omon563/vpc/aws//modules/subnets | 1.0.0 |
| <a name="module_cache-network"></a> [cache-network](#module\_cache-network) | so1omon563/vpc/aws//modules/subnets | 1.0.0 |
| <a name="module_endpoints"></a> [endpoints](#module\_endpoints) | so1omon563/vpc/aws//modules/gateway-endpoints//by-route-table | 1.0.0 |
| <a name="module_postgres-nacl"></a> [postgres-nacl](#module\_postgres-nacl) | so1omon563/vpc/aws//modules/subnet-nacl-rules/service | 1.0.0 |
| <a name="module_private-nacl"></a> [private-nacl](#module\_private-nacl) | so1omon563/vpc/aws//modules/subnet-nacl-rules/generic | 1.0.0 |
| <a name="module_public-nacl"></a> [public-nacl](#module\_public-nacl) | so1omon563/vpc/aws//modules/subnet-nacl-rules/generic | 1.0.0 |
| <a name="module_rds-network"></a> [rds-network](#module\_rds-network) | so1omon563/vpc/aws//modules/subnets | 1.0.0 |
| <a name="module_redis-nacl"></a> [redis-nacl](#module\_redis-nacl) | so1omon563/vpc/aws//modules/subnet-nacl-rules/service | 1.0.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | so1omon563/vpc/aws | 1.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_route.ipv4_default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion-network"></a> [bastion-network](#output\_bastion-network) | n/a |
| <a name="output_endpoints"></a> [endpoints](#output\_endpoints) | n/a |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | n/a |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
