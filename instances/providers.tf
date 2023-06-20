# provider "aws" {
#   profile = var.profile
#   region  = var.region
#   alias   = var.alias
# }

provider "aws" {
  region  = "us-west-1"
  alias   = "ca"
  profile = "raven"
}

provider "aws" {
  region  = "us-west-2"
  alias   = "oregon"
  profile = "raven"
}

provider "aws" {
  region = "ca-central-1"
  alias = "can"
  profile = "raven"
}

provider "aws" {
  region = "us-east-1"
  alias = "vir"
  profile = "raven"
}