# ---------------------------------------------------------
# Security Group
# ---------------------------------------------------------

resource "aws_security_group" "jenkins" {
  name        = "jenkins-sg"
  description = "Security group for Jenkins Master and Worker"
  vpc_id      = var.vpc_id

  tags = {
    Name = "Jenkins-SG"
  }
}


# ---------------------------------------------------------
# Security Group ingress rules
# ---------------------------------------------------------

resource "aws_vpc_security_group_ingress_rule" "allow_ports" {
  for_each = toset(var.list_of_open_ports)

  security_group_id = aws_security_group.jenkins.id

  cidr_ipv4 = "0.0.0.0/0"

  from_port = tonumber(each.value)
  to_port   = tonumber(each.value)

  ip_protocol = "tcp"
}


# ---------------------------------------------------------
# Security Group egress
# ---------------------------------------------------------

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.jenkins.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}


# ---------------------------------------------------------
# Jenkins Master
# ---------------------------------------------------------

resource "aws_instance" "jenkins_master" {

  ami = data.aws_ami.ubuntu_26_04.id

  instance_type = var.master_instance_type

  subnet_id = var.public_subnet_id

  vpc_security_group_ids = [
    aws_security_group.jenkins.id
  ]

  key_name = var.key_name

  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash

    mkdir -p /home/ubuntu/.ssh

    echo '${var.public_key}' >> /home/ubuntu/.ssh/authorized_keys

    chmod 700 /home/ubuntu/.ssh
    chmod 600 /home/ubuntu/.ssh/authorized_keys

    chown -R ubuntu:ubuntu /home/ubuntu/.ssh
  EOF

  tags = {
    Name = "Jenkins-Master"
    Role = "jenkins-master"
  }
}


# ---------------------------------------------------------
# Jenkins Worker
# ---------------------------------------------------------

resource "aws_instance" "jenkins_worker" {

  ami = data.aws_ami.ubuntu_26_04.id

  instance_type = var.worker_instance_type

  subnet_id = var.private_subnet_id

  vpc_security_group_ids = [
    aws_security_group.jenkins.id
  ]

  key_name = var.key_name

  associate_public_ip_address = false

  instance_market_options {
  market_type = "spot"
}

  user_data = <<-EOF
    #!/bin/bash

    mkdir -p /home/ubuntu/.ssh

    echo '${var.public_key}' >> /home/ubuntu/.ssh/authorized_keys

    chmod 700 /home/ubuntu/.ssh
    chmod 600 /home/ubuntu/.ssh/authorized_keys

    chown -R ubuntu:ubuntu /home/ubuntu/.ssh
  EOF

  tags = {
    Name = "Jenkins-Worker"
    Role = "jenkins-worker"
  }
}