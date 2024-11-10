resource "aws_security_group" "servers_sg" {
  name   = "${var.project}-hipaa-servers-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.hipaa_bh_ips
  }

  ingress {
    description     = "from alb"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-servers-sg"
  }
}

resource "aws_security_group" "vpn_sg" {
  name   = "${var.project}-hipaa-vpn-servers-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.hipaa_bh_ips
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-vpn-servers-sg"
  }
}

resource "aws_security_group" "aurora_mysql_sg" {
  name   = "${var.project}-aurora-mysql-rds-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    description     = "allow from hipaa servers"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.servers_sg.id]
  }

  ingress {
    description     = "allow from omfina servers"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.omfina_sg.id]
  }

  ingress {
    description     = "allow from newsea servers"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.newsea_sg.id]
  }

  ingress {
    description     = "allow from rhahea servers"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.rhahea_sg.id]
  }

  ingress {
    description     = "allow from eththe servers"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.eththe_sg.id]
  }

  ingress {
    description     = "allow from ntca servers"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ntca_sg.id]
  }

  ingress {
    description     = "allow from conmin servers"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.conmin_sg.id]
  }

  ingress {
    description = "Bastion Host"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.hipaa_bh_ips
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-aurora-mysql-rds-sg"
  }
}

# alb sg
resource "aws_security_group" "alb_sg" {
  name   = "${var.project}-alb-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "http"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-alb-sg"
  }
}

# opensearch
resource "aws_security_group" "opensearch_security_group" {
  name        = "${var.project}-opensearch-sg"
  vpc_id      = module.vpc.vpc_id
  description = "Allow inbound HTTP traffic"

  ingress {
    description = "HTTP from hipaa server"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"

    security_groups = [aws_security_group.servers_sg.id]
  }

  ingress {
    description     = "from omfina servers"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.omfina_sg.id]
  }

  ingress {
    description     = "from newsea servers"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.newsea_sg.id]
  }

  ingress {
    description     = "from rhahea servers"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.rhahea_sg.id]
  }

  ingress {
    description     = "from eththe servers"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.eththe_sg.id]
  }

  ingress {
    description     = "from ntca servers"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.ntca_sg.id]
  }

  ingress {
    description     = "from conmin servers"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.conmin_sg.id]
  }

}

#-------------------------------------------
#               OMFINA
#-------------------------------------------
resource "aws_security_group" "omfina_sg" {
  name   = "${var.project}-omfina-servers-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.hipaa_bh_ips
  }

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.9.8.122/32"]
  }

  ingress {
    description     = "from alb"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-servers-sg"
  }
}

#-------------------------------------------
#               NEWSEA
#-------------------------------------------
resource "aws_security_group" "newsea_sg" {
  name   = "${var.project}-newsea-servers-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.hipaa_bh_ips
  }

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.9.8.122/32"]
  }

  ingress {
    description     = "from alb"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-newsea-servers-sg"
  }
}

#-------------------------------------------
#               RHAHEA
#-------------------------------------------
resource "aws_security_group" "rhahea_sg" {
  name   = "${var.project}-rhahea-servers-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.hipaa_bh_ips
  }

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.9.8.122/32"]
  }

  ingress {
    description     = "from alb"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-rhahea-servers-sg"
  }
}

#-------------------------------------------
#               ETHTHE
#-------------------------------------------
resource "aws_security_group" "eththe_sg" {
  name   = "${var.project}-eththe-servers-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.hipaa_bh_ips
  }

  ingress {
    description     = "from alb"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-eththe-servers-sg"
  }
}

#-------------------------------------------
#               NTCA
#-------------------------------------------
resource "aws_security_group" "ntca_sg" {
  name   = "${var.project}-ntca-servers-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.hipaa_bh_ips
  }

  ingress {
    description     = "from alb"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-ntca-servers-sg"
  }
}

#-------------------------------------------
#               CONMIN
#-------------------------------------------
resource "aws_security_group" "conmin_sg" {
  name   = "${var.project}-conmin-servers-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.hipaa_bh_ips
  }

  ingress {
    description     = "from alb"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-conmin-servers-sg"
  }
}