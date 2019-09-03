module "networkModule" {
  source          = "./modules/network"
  access_key      = var.access_key
  secret_key      = var.secret_key
  region          = var.region
  environment_tag = var.environment_tag
}

module "securityGroupModule" {
  source          = "./modules/securityGroup"
  access_key      = var.access_key
  secret_key      = var.secret_key
  region          = var.region
  vpc_id          = module.networkModule.vpc_id
  environment_tag = var.environment_tag
  instance_ip     = module.instanceModule.instance_eip
}

module "instanceModule" {
  source             = "./modules/instance"
  access_key         = var.access_key
  secret_key         = var.secret_key
  region             = var.region
  vpc_id             = module.networkModule.vpc_id
  subnet_public_id   = module.networkModule.public_subnets
  security_group_ids = ["${module.securityGroupModule.sg_22}", "${module.securityGroupModule.sg_80}"]
  environment_tag    = var.environment_tag
}

module "db" {
  source                   = "./modules/postgresql"
  access_key               = var.access_key
  secret_key               = var.secret_key
  account_id               = "999781633729"
  region                   = var.region
  vpc_id                   = module.networkModule.vpc_id
  rds_db_subnet_group_name = module.networkModule.public_subnets_1b
  service_name             = "test"
  environment              = "dev"
  description              = "Postgres server to store Github data"
  security_group_ids       = ["${module.securityGroupModule.sg_22}", "${module.securityGroupModule.sg_5432}"]
  instance_class           = "db.t2.medium"
  allocated_storage        = 20


  # Change to valid db subnet group name
  #db_subnet_group_name = var.db_subnet_group_name

  # Change to valid parameter group name
  parameter_group_name = "default"

}