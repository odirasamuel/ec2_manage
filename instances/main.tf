module "instance_ca" {
  count                  = (terraform.workspace == "ca") ? 1 : 0
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
    aws = aws.ca
  }
}

module "instance_can" {
  count                  = (terraform.workspace == "can") ? 1 : 0
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
    aws = aws.can
  }
}

module "instance_virginia" {
  count                  = (terraform.workspace == "vir") ? 1 : 0
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
    aws = aws.vir
  }
}

# output "instances_ca" {
#   value = module.instance_ca[0].instance_public_ips
# }

# output "instances_can" {
#   value = module.instance_can[0].instance_public_ips
# }

# output "instances_virginia" {
#   value = module.instance_virginia[0].instance_public_ips
# }