module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name                    = "${var.project}-vpc"
  cidr                    = var.vpc_cidr
  azs                     = var.azs
  private_subnets         = var.private_subnets
  database_subnets        = var.database_subnets
  public_subnets          = var.public_subnets
  enable_nat_gateway      = true
  enable_dns_hostnames    = true
  map_public_ip_on_launch = true

  public_subnet_tags = {
    Name = "${var.project}-public-subnet"
  }

  private_subnet_tags = {
    Name = "${var.project}-private-subnet"
  }

  database_subnet_tags = {
    Name = "${var.project}-database-subnet"
  }
}