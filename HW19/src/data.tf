data "aws_ami" "ubuntu_26_04" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-resolute-26.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

}

data "aws_subnets" "selected" {
  filter {
    name   = "tag:Name"
    values = ["*public*"] # insert values here
  }
}

output "test2" {
  value = data.aws_subnets.public
}