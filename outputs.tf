output "nginx-vpc" {
  value = module.vpc.nginx-vpc
}
output "nginx-subnet-1" {
  value = module.vpc.nginx-subnet-1
}
output "sg" {
  value = module.sg.sg
}

output "nginx-server" {
  value = module.ec2.nginx-server
}