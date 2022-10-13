module "private-nacl" {
  source  = "../../modules/subnet-nacl-rules/generic/"
  nacl_id = module.vpc.private_nacl.id

}
