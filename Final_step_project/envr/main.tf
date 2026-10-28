module "network" {
  source = "../modules/network"

  env         = var.env
  aws_region  = var.aws_region
  vpc_cidr    = var.vpc_cidr
  subnet_cidr = var.subnet_cidr
}

module "eks" {
  source = "../modules/eks"

  env             = var.env
  aws_region      = var.aws_region
  cluster_name    = var.cluster_name
  vpc_id          = module.network.vpc_id
  private_subnets = module.network.private_subnets
}