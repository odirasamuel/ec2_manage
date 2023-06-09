module "instance" {
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
  # profile                = var.profile
  # alias                  = var.alias
  # region                 = var.region
  providers = {
    aws = aws.oregon
  }
}

output "instances" {
  value = module.instance.instance_public_ips
}