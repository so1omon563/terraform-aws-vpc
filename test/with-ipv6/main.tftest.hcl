mock_provider "aws" {
  mock_data "aws_caller_identity" {
    defaults = {
      account_id = "123456789012"
    }
  }

  mock_data "aws_region" {
    defaults = {
      id   = "us-east-1"
      name = "us-east-1"
    }
  }

  mock_data "aws_availability_zones" {
    defaults = {
      names = ["us-east-1a", "us-east-1b"]
    }
  }
}

# Some basic unit testing to verify that selected outputs of the main module return expected results.
# In order to reduce testing cost, only items that can be verified via a `terraform plan` are being tested here.

run "verify_vpc_outputs_plan" {
  command = plan
  assert {
    condition     = module.vpc.vpc.cidr_block == "10.255.255.192/26"
    error_message = "CIDR Block did not match expected result."
  }
  assert {
    condition     = module.vpc.vpc.assign_generated_ipv6_cidr_block == true
    error_message = "ipv6 association does not match expected result."
  }
  assert {
    condition     = length(module.vpc.nat_gateways) == 2
    error_message = "Number of NAT Gateways does not match expected result."
  }
  assert {
    condition     = length(module.vpc.private_nacl) == 4
    error_message = "Private NACL configuration does not match expected result."
  }
  assert {
    condition     = length(module.vpc.private_route_table_ids) == 2
    error_message = "Number of Private Route Table IDs does not match expected result."
  }
  assert {
    condition     = length(module.vpc.private_subnets) == 2
    error_message = "Number of Private Subnets does not match expected result."
  }
  assert {
    condition     = length(module.vpc.public_nacl) == 4
    error_message = "Public NACL configuration does not match expected result."
  }
  assert {
    condition     = length(module.vpc.public_route_table_ids) == 1
    error_message = "Number of Public Route Table IDs does not match expected result."
  }
  assert {
    condition     = length(module.vpc.public_subnets) == 2
    error_message = "Number of Public Subnets does not match expected result."
  }
}
