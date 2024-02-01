# Only Private Subnets

Example demonstrates creating a VPC with ONLY private subnets.

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
  version = "2.0.0"

  public_cidrs = []

  name = "example-private-only-vpc"
  tags = {
    example = "true"
  }
}

output "network" {
  value = module.vpc
}
```

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | so1omon563/vpc/aws | 2.0.0 |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network"></a> [network](#output\_network) | n/a |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
