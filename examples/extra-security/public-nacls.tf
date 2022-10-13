module "public-nacl" {
  source  = "../../modules/subnet-nacl-rules//generic"
  nacl_id = module.vpc.public_nacl.id
}
