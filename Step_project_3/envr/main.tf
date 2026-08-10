module "network" {
  source = "../modules/network"

  env         = var.env
  aws_region  = var.aws_region
  vpc_cidr    = var.vpc_cidr
  subnet_cidr = var.subnet_cidr
}

module "ec2" {
  source = "../modules/ec2"

  public_subnet_id  = module.network.public_subnets[0]
  private_subnet_id = module.network.private_subnets[0]

  vpc_id = module.network.vpc_id

  list_of_open_ports = var.list_of_open_ports

  key_name   = var.key_name
  public_key = file(pathexpand("~/.ssh/main-keypair-1.pub"))

  master_instance_type = var.master_instance_type
  worker_instance_type = var.worker_instance_type
}

resource "local_file" "ansible_inventory" {
  filename = "${path.module}/inventory.ini"

  content = <<-EOT
[jenkins_master]
master ansible_host=${module.ec2.master_public_ip}

[jenkins_worker]
worker ansible_host=jenkins-worker

[jenkins_master:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=/home/denys/.ssh/main-keypair-1.pem
ansible_python_interpreter=/usr/bin/python3

[jenkins_worker:vars]
ansible_user=ubuntu
ansible_python_interpreter=/usr/bin/python3
EOT
}