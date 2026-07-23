resource "aws_instance" "public_vm" {
  ami                    = data.aws_ami.ubuntu_26_04.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = "main-keypair-1"
  user_data              = file(var.user_data_file)
  tags = {
    Name = "HM_20_VM_Public"
  }
}