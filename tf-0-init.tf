terraform {
  required_version = ">= 0.15"
  backend "s3" {
    bucket  = "hipaa-terraform-state"
    key     = "hipaa/terraform/terraform.tfstate"
    region  = "us-west-2"
    profile = "hipaa-admin"
  }

}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
  # default_tags {
  #   tags = {
  #     backup           = "yes"
  #   }
  # }
}

provider "aws" {
  alias   = "networking"
  profile = var.net_aws_profile
  region  = var.aws_region
}