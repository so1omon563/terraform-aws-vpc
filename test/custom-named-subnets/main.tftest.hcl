# Some basic unit testing to verify that selected outputs of the main module return expected results.
# In order to reduce testing cost, only items that can be verified via a `terraform plan` are being tested here.

run "verify_vpc_outputs_plan" {
  command = plan
  assert {
    condition     = module.vpc.tags.Name == "example-custom-subnets-vpc"
    error_message = "Name Tag did not match expected result."
  }
  assert {
    condition     = module.vpc.tags.example == "true" && module.vpc.tags.environment == "dev" && module.vpc.tags.terraform == "true"
    error_message = "One or more tags did not match expected result."
  }
  assert {
    condition     = module.vpc.vpc.cidr_block == "10.20.32.0/20"
    error_message = "CIDR Block did not match expected result."
  }
  assert {
    condition     = module.vpc.vpc.assign_generated_ipv6_cidr_block == false
    error_message = "ipv6 association does not match expected result."
  }
  assert {
    condition     = module.vpc.vpc.eigw_id == null
    error_message = "Egress-only Internet Gateway configuration does not match expected result."
  }
  assert {
    condition     = length(module.vpc.nat_gateways) == 0
    error_message = "Number of NAT Gateways does not match expected result."
  }
  assert {
    condition     = module.vpc.private_nacl == null
    error_message = "Private NACL configuration does not match expected result."
  }
  assert {
    condition     = length(module.vpc.private_route_table_ids) == 0
    error_message = "Number of Private Route Table IDs does not match expected result."
  }
  assert {
    condition     = length(module.vpc.private_subnets) == 0
    error_message = "Number of Private Subnets does not match expected result."
  }
  assert {
    condition     = module.vpc.public_nacl == null
    error_message = "Public NACL configuration does not match expected result."
  }
  assert {
    condition     = length(module.vpc.public_route_table_ids) == 0
    error_message = "Number of Public Route Table IDs does not match expected result."
  }
  assert {
    condition     = length(module.vpc.public_subnets) == 0
    error_message = "Number of Public Subnets does not match expected result."
  }
  assert {
    condition     = length(module.custom-network.route_table_ids) == 1
    error_message = "Number of Route Table IDs does not match expected result."
  }
  assert {
    condition     = length(module.custom-network.subnets) == 2
    error_message = "Number of subnets does not match expected result."
  }
  assert {
    condition     = module.custom-network.subnets[0].tags.Name == "custom-1"
    error_message = "Subnet name does not match expected result."
  }
  assert {
    condition     = module.custom-network.subnets[1].tags.Name == "custom-2"
    error_message = "Subnet name does not match expected result."
  }
  assert {
    condition     = module.custom-network.nacl.tags.Name == "custom-nacl"
    error_message = "Subnet name does not match expected result."
  }
  assert {
    condition     = length(module.custom-network.route_table_names) == 1
    error_message = "Number of Route Table Names does not match expected result."
  }
  assert {
    condition     = module.custom-network.route_table_names[0] == "custom-routes"
    error_message = "Route table name does not match expected result."
  }
}
