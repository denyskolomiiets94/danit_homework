module "network" {
  source = "../modules/network"

  env         = var.env
  aws_region  = var.aws_region
  vpc_cidr    = var.vpc_cidr
  subnet_cidr = var.subnet_cidr
}

module "ec2" {
  source = "../modules/ec2"

  subnet_ids          = module.network.public_subnets
  vpc_id             = module.network.vpc_id
  list_of_open_ports = var.list_of_open_ports
  instance_type  = var.instance_type
}

resource "local_file" "ansible_inventory" {
  filename = "${path.module}/inventory.ini"

  content = <<-EOT
    [webservers]
    web-1 ansible_host=${module.ec2.public_ips["web-1"]}
    web-2 ansible_host=${module.ec2.public_ips["web-2"]}

    [webservers:vars]
    ansible_user=ubuntu
    ansible_ssh_private_key_file=/home/denys/.ssh/main-keypair-1.pem
    ansible_python_interpreter=/usr/bin/python3
  EOT
}