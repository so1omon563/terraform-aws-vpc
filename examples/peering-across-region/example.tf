provider "aws" {
  alias  = "requester"
  region = "us-west-1"

  default_tags {
    tags = {
      environment = "dev"
      terraform   = "true"
      region      = "us-west-1"
    }
  }
}

provider "aws" {
  alias  = "accepter"
  region = "us-west-2"

  default_tags {
    tags = {
      environment = "dev"
      terraform   = "true"
      region      = "us-west-2"
    }
  }
}

# Create the requester VPC
module "req" {
  providers = {
    aws = aws.requester
  }

  source  = "so1omon563/vpc/aws"
  version = "2.2.0"

  name = "requester-vpc"
  tags = {
    example = "true"
  }
  vpc           = { cidr_block = "10.1.0.0/16" }
  public_cidrs  = ["10.1.0.0/24", "10.1.1.0/24"]
  private_cidrs = ["10.1.16.0/24", "10.1.17.0/24"]
}

# Create the accepter VPC
module "acp" {
  providers = {
    aws = aws.accepter
  }

  source  = "so1omon563/vpc/aws"
  version = "2.2.0"

  name = "accepter-vpc"
  tags = {
    example = "true"
  }
  vpc           = { cidr_block = "10.2.0.0/16" }
  public_cidrs  = ["10.2.0.0/24", "10.2.1.0/24"]
  private_cidrs = ["10.2.16.0/24", "10.2.17.0/24"]
}

# Create the peering connection
module "pcx" {
  providers = {
    aws.requester = aws.requester
    aws.accepter  = aws.accepter
  }

  source  = "so1omon563/vpc/aws//modules/peering"
  version = "2.2.0"

  name = "peering-across-region-example"
  tags = {
    example = "true"
  }
  auto_accept      = true
  requester_vpc_id = module.req.vpc.id
  accepter_vpc_id  = module.acp.vpc.id
}


# Create route table entries on each side to allow traffic to traverse the VPC peering connection
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
