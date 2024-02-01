# Some basic unit testing to verify that selected outputs of the main module return expected results.
# In order to reduce testing cost, only items that can be verified via a `terraform plan` are being tested here.

run "verify_vpc_outputs_plan" {
  command = plan
  assert {
    condition     = module.vpc.tags.Name == var.name
    error_message = "Name Tag did not match expected result."
  }
  assert {
    condition     = module.vpc.tags.example == "true" && module.vpc.tags.environment == "dev" && module.vpc.tags.terraform == "true"
    error_message = "One or more tags did not match expected result."
  }
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
    condition     = length(module.vpc.private_nacl) == 3
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
    condition     = length(module.vpc.public_nacl) == 3
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
  assert {
    condition     = module.vpc.vpc.eigw_id == "(known after apply)"
    error_message = "Egress-only Internet Gateway configuration does not match expected result."
  }
}
