
resource "aws_security_group" "sg" {
  vpc_id = var.vpc_id
  name   = "nginx-sg"
  ingress {
    description = "open ssh port"
    from_port   = 22
    to_port     = 22
    cidr_blocks = [var.my_ip]
    protocol    = "tcp"
  }
  dynamic "ingress" {
    iterator = port
    for_each = var.custom_ports
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    cidr_blocks     = ["0.0.0.0/0"]
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    prefix_list_ids = []
  }
  tags = {
    Name = "${var.env_prefix}-sg"
  }
}