resource "aws_ec2_transit_gateway_vpc_attachment" "hipaa" {
  subnet_ids         = module.vpc.private_subnets
  transit_gateway_id = data.aws_ec2_transit_gateway.faye_networking_tgw.id
  vpc_id             = module.vpc.vpc_id
  tags = {
    Name      = "${var.project}-tgw-attachment"
    Terraform = "true"
    Project   = var.project
  }
}

resource "aws_route" "route_tgw" {
  route_table_id         = module.vpc.private_route_table_ids[0]
  destination_cidr_block = "10.9.128.0/20"
  transit_gateway_id     = data.aws_ec2_transit_gateway.faye_networking_tgw.id
}