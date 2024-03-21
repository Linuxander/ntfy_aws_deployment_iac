locals {
  user_data_file_path = "${path.module}/scripts/user-data-ec2-ntfy.sh"
}

resource "aws_instance" "ec2_ntfy" {
  ami           = data.aws_ami.latest_t3_micro_ami.id
  instance_type = "t3.micro"

  key_name   = "aws_key_pair_ec2_ntfy_server"
  monitoring = true

  subnet_id              = var.netmod_subnet_default_id
  vpc_security_group_ids = [var.netmod_security_group_default_id]

  associate_public_ip_address = true

  user_data = file("${local.user_data_file_path}")

  tags = {
    Name = "${var.project_name} - ec2"
  }
}
