data "aws_ami" "ec2-ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_instance" "nginx-server" {
  ami                         = data.aws_ami.ec2-ami.id
  instance_type               = var.instance_type
  availability_zone           = var.avail_zone
  subnet_id                   = var.subnet_id
  key_name                    = aws_key_pair.my-key.key_name
  vpc_security_group_ids      = [var.sg_id]
  associate_public_ip_address = true
  user_data = file(var.user_data_file_location)
  tags = {
    Name = "${var.env_prefix}-server"
  }
  depends_on = [ aws_key_pair.my-key ]
}

resource "aws_key_pair" "my-key" {
  key_name   = var.key_name
  public_key = file(var.public_key_location)
  tags = {
    Name = "${var.env_prefix}-vpc"
  }
}