resource "aws_instance" "public_vm" {
  ami                    = data.aws_ami.ubuntu_26_04.id
  instance_type          = var.instance_type
  subnet_id              = module.network.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.my_sg_public.id]
  key_name               = "main-keypair-1"
  user_data              = file("./user-data.sh")
  tags = {
    Name = "HM_20_VM_Public"
  }
}

output "public_vm_ip" {
  value = aws_instance.public_vm.public_ip
}

resource "aws_security_group" "my_sg_public" {
  name        = "tf-sg-public"
  description = "Test"
  vpc_id      = module.network.vpc_id

  tags = {
    Name = "tf-sg-public"
  }
}

resource "aws_vpc_security_group_ingress_rule" "public_allow_ssh" {
  for_each          = toset(var.list_of_open_ports)
  security_group_id = aws_security_group.my_sg_public.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = tonumber(each.value)
  to_port           = tonumber(each.value)
  ip_protocol       = "tcp"
}


resource "aws_vpc_security_group_egress_rule" "public_allow_outbound_all" {
  security_group_id = aws_security_group.my_sg_public.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}