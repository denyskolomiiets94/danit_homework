module "network" {
  source = "../../modules/network"

  env         = var.env
  aws_region  = var.aws_region
  vpc_cidr    = var.vpc_cidr
  subnet_cidr = var.subnet_cidr
}

module "security_group" {
  source = "../../modules/security_group"

  vpc_id             = module.network.vpc_id
  list_of_open_ports = var.list_of_open_ports
}

module "ec2" {
  source = "../../modules/ec2"

  subnet_id         = module.network.public_subnets[0]
  security_group_id = module.security_group.security_group_id

  instance_type  = var.instance_type
  user_data_file = "${path.module}/user-data.sh"
}