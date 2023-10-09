provider "aws" {
  region = var.region
}

module "vpc" {
  source            = "./vpc"
  vpc_cidr_block    = var.vpc_cidr_block
  subnet_cidr_block = var.subnet_cidr_block
  avail_zone        = var.avail_zone
  env_prefix        = var.env_prefix

}

module "sg" {
  source       = "./sg"
  vpc_id       = module.vpc.nginx-vpc.id
  env_prefix   = var.env_prefix
  custom_ports = var.custom_ports
  my_ip        = var.my_ip
}

module "ec2" {
  source                  = "./ec2"
  instance_type           = var.instance_type
  avail_zone              = var.avail_zone
  key_name                = var.key_name
  subnet_id               = module.vpc.nginx-subnet-1.id
  public_key_location     = var.public_key_location
  env_prefix              = var.env_prefix
  sg_id                   = module.sg.sg.id
  user_data_file_location = var.user_data_file_location

}
