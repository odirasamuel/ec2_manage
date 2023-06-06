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