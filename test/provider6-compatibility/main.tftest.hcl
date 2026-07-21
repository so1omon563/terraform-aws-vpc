mock_provider "aws" {
  mock_data "aws_region" {
    defaults = {
      region = "us-east-1"
    }
  }

  mock_data "aws_subnets" {
    defaults = {
      ids = ["subnet-1", "subnet-2"]
    }
  }

  mock_data "aws_route_table" {
    defaults = {
      id = "rtb-test"
    }
  }
}

mock_provider "aws" {
  alias = "requester"

  mock_data "aws_region" {
    defaults = {
      region = "us-west-1"
    }
  }
}

mock_provider "aws" {
  alias = "accepter"

  mock_data "aws_caller_identity" {
    defaults = {
      account_id = "123456789012"
    }
  }

  mock_data "aws_region" {
    defaults = {
      region = "us-west-2"
    }
  }
}

run "gateway_endpoints_discover_route_tables_by_vpc" {
  command = plan

  module {
    source = "../../modules/gateway-endpoints/by-vpc"
  }

  variables {
    name   = "provider6-test"
    vpc_id = "vpc-12345678"
  }

  assert {
    condition     = aws_vpc_endpoint.s3.service_name == "com.amazonaws.us-east-1.s3"
    error_message = "S3 gateway endpoint did not use the provider region."
  }

  assert {
    condition     = length(aws_vpc_endpoint_route_table_association.s3) == 2
    error_message = "S3 gateway endpoint did not discover both subnet route tables."
  }

  assert {
    condition     = length(aws_vpc_endpoint_route_table_association.dynamodb) == 2
    error_message = "DynamoDB gateway endpoint did not discover both subnet route tables."
  }
}

run "vpn_gateway_discovers_route_tables_by_vpc" {
  command = plan

  module {
    source = "../../modules/vpn-gateway/by-vpc"
  }

  variables {
    name   = "provider6-test"
    vpc_id = "vpc-12345678"
  }

  assert {
    condition     = length(aws_vpn_gateway_route_propagation.routes) == 2
    error_message = "VPN gateway did not discover both subnet route tables."
  }
}

run "peering_uses_declared_provider_aliases" {
  command = plan

  module {
    source = "../../modules/peering"
  }

  providers = {
    aws.requester = aws.requester
    aws.accepter  = aws.accepter
  }

  variables {
    accepter_vpc_id  = "vpc-accepter"
    auto_accept      = true
    name             = "provider6-test"
    requester_vpc_id = "vpc-requester"
  }

  assert {
    condition     = aws_vpc_peering_connection.pcx.peer_region == "us-west-2"
    error_message = "Peering connection did not use the accepter provider region."
  }

  assert {
    condition     = length(aws_vpc_peering_connection_options.requester) == 0
    error_message = "Cross-region peering unexpectedly created requester DNS options."
  }
}
