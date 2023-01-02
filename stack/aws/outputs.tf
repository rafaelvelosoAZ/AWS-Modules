output "public_subnet_ids" {
  value = module.vpc.subnet_public
}

output "private_subnet_ids" {
  value = module.vpc.subnet_private
}