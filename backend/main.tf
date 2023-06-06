module "mona_c_datalake_dev_" {
  source = "../modules/s3_backend"
  stack_name = var.stack_name
}