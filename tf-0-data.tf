# Get the latest AMI ID for the CIS Ubuntu 20.04 OS
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["CIS Ubuntu Linux 22.04 LTS ARM Benchmark*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["arm64"]
  }
}

data "aws_ec2_transit_gateway" "faye_networking_tgw" {
  filter {
    name   = "tag:Name"
    values = ["faye-networking-transit-gateway"]
  }
}

# ACM
data "aws_acm_certificate" "fbsghosting" {
  domain   = "*.${var.domain}"
  statuses = ["ISSUED"]
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
data "aws_elb_service_account" "current" {}

# Route53 hipaa hosting
data "aws_route53_zone" "hipaa_zone" {
  provider = aws.networking
  name     = var.hipaa_domain
}

# Route53 hipaa hosting
data "aws_route53_zone" "fayebsg_prv" {
  provider     = aws.networking
  name         = "fayebsg.prv"
  private_zone = true
}