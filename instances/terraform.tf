terraform {
  required_version = ">= 1.3"
  required_providers {
    aws = { version = "~> 4.9" }
  }
  backend "s3" {
    bucket         = "raven-tf-state-bucket"
    dynamodb_table = "ravenc-tf-state-lock"
    key            = "raven-tf-state/raven"
    encrypt        = true
    profile        = "raven"
    region         = "us-east-2"
  }
}