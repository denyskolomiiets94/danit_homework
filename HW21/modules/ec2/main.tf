resource "aws_instance" "web" {
  for_each = {
    for index, subnet_id in var.subnet_ids :
    "web-${index + 1}" => subnet_id
  }

  ami                    = data.aws_ami.ubuntu_26_04.id
  instance_type          = var.instance_type
  subnet_id              = each.value
  vpc_security_group_ids = [aws_security_group.my_sg_public.id]

  key_name = "main-keypair-1"

  tags = {
    Name = "HW21-${each.key}"
  }
}

resource "aws_security_group" "my_sg_public" {
  name        = "hw21-sg-public"
  description = "Security group for HW21 EC2 instances"
  vpc_id      = var.vpc_id

  tags = {
    Name = "HW21-SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "public_allow" {
  for_each = toset(var.list_of_open_ports)

  security_group_id = aws_security_group.my_sg_public.id
  cidr_ipv4         = "0.0.0.0/0"

  from_port = tonumber(each.value)
  to_port   = tonumber(each.value)

  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "public_allow_outbound_all" {
  security_group_id = aws_security_group.my_sg_public.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}