module "private-nacl" {
  source  = "so1omon563/vpc/aws//modules/subnet-nacl-rules/generic"
  version = "1.0.0"

  nacl_id = module.vpc.private_nacl.id

}
