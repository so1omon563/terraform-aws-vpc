provider "aws" {
  alias  = "requester"
  region = "us-west-1"
}

provider "aws" {
  alias  = "accepter"
  region = "us-west-2"
}

locals {
  tags = {
    t_dcl         = "1"
    t_environment = "DEV"
    t_AppID       = "SVC00000"
  }
}

module "req" {
  providers = {
    aws = aws.requester
  }

  source = "../.."
  name   = "requester-vpc"
  tags   = local.tags

  vpc           = { cidr = "10.1.0.0/16" }
  public_cidrs  = ["10.1.0.0/24", "10.1.1.0/24"]
  private_cidrs = ["10.1.16.0/24", "10.1.17.0/24"]
}

module "acp" {
  providers = {
    aws = aws.accepter
  }

  source = "../.."
  name   = "accepter-vpc"
  tags   = local.tags

  vpc           = { cidr = "10.2.0.0/16" }
  public_cidrs  = ["10.2.0.0/24", "10.2.1.0/24"]
  private_cidrs = ["10.2.16.0/24", "10.2.17.0/24"]
}

module "pcx" {
  providers = {
    aws.requester = aws.requester
    aws.accepter  = aws.accepter
  }

  source = "../../modules/peering"
  name   = "peering-in-region-example"
  tags   = local.tags

  auto_accept      = true
  requester_vpc_id = module.req.vpc["id"]
  accepter_vpc_id  = module.acp.vpc["id"]
}

/*
** Create route table entries on each side to allow traffic to traverse the VPC peering connection
*/
resource "aws_route" "req_routes" {
  provider       = aws.requester
  count          = length(module.req.private_route_table_ids)
  route_table_id = module.req.private_route_table_ids[count.index]

  destination_cidr_block    = "10.2.0.0/16"
  vpc_peering_connection_id = module.pcx.peering_connection.id
}

resource "aws_route" "acp_routes" {
  provider       = aws.accepter
  count          = length(module.acp.private_route_table_ids)
  route_table_id = module.acp.private_route_table_ids[count.index]

  destination_cidr_block    = "10.1.0.0/16"
  vpc_peering_connection_id = module.pcx.peering_connection.id
}

output "peering" { value = module.pcx }
