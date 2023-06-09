module "oregon_instance" {
  source                 = "../modules/deploy_ec2"
  cidr_block             = var.cidr_block
  public_subnets_cidr    = var.public_subnets_cidr
  private_subnets_cidr   = var.private_subnets_cidr
  availability_zones     = var.availability_zones
  stack_name             = var.stack_name
  instance_type          = var.instance_type
  instance_template_type = var.instance_template_type
  region_specific        = var.region_specific
  wallet_address         = var.wallet_address
  worker                 = var.worker
  pool_url               = var.pool_url
  pool_port              = var.pool_port
}

output "oregon_instances" {
  value = module.oregon_instance.instance_public_ips
}