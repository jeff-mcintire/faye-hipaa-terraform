resource "random_password" "postgres" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_ssm_parameter" "rds-aurora-mysql-01-pass" {
  tier  = "Standard"
  name  = "/rds/${var.project}-rds-aurora-mysql-01/PASS"
  type  = "SecureString"
  value = random_password.postgres.result
}

resource "aws_db_subnet_group" "aurora_mysql_subnet_group" {
  name       = "${var.project}-rds-aurora-mysql-subnet-group-01"
  subnet_ids = module.vpc.database_subnets
}

resource "aws_rds_cluster" "aurora_mysql_cluster" {
  cluster_identifier                  = "${var.project}-rds-aurora-mysql-01"
  engine                              = var.aurora_mysql_engine
  engine_mode                         = "provisioned"
  engine_version                      = var.aurora_mysql_engine_version
  master_username                     = var.db_username
  master_password                     = aws_ssm_parameter.rds-aurora-mysql-01-pass.value
  backup_retention_period             = 35
  deletion_protection                 = true
  copy_tags_to_snapshot               = true
  iam_database_authentication_enabled = true
  db_subnet_group_name                = aws_db_subnet_group.aurora_mysql_subnet_group.name
  vpc_security_group_ids              = [aws_security_group.aurora_mysql_sg.id]
  #   db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora_parameter_group.id
  serverlessv2_scaling_configuration {
    # auto_pause               = true
    max_capacity = 24
    min_capacity = 1
    # seconds_until_auto_pause = 300
  }

  enabled_cloudwatch_logs_exports = [
    "audit",
    "error",
    "general",
    "slowquery",
  ]
}

resource "aws_db_parameter_group" "aurora_mysql_cluster_instance" {
  name        = "${var.project}-rds-aurora-mysql-01-pg"
  family      = "aurora-mysql8.0"
  description = "RDS default cluster parameter group"
}

# To create writer instance
resource "aws_rds_cluster_instance" "aurora_mysql_cluster_instance" {
  identifier              = "${var.project}-rds-aurora-mysql-01"
  cluster_identifier      = aws_rds_cluster.aurora_mysql_cluster.id
  instance_class          = "db.serverless"
  engine                  = aws_rds_cluster.aurora_mysql_cluster.engine
  engine_version          = aws_rds_cluster.aurora_mysql_cluster.engine_version
  db_subnet_group_name    = aws_db_subnet_group.aurora_mysql_subnet_group.name
  db_parameter_group_name = aws_db_parameter_group.aurora_mysql_cluster_instance.id
  monitoring_interval     = 60
}

resource "aws_rds_cluster_instance" "aurora_mysql_cluster_rr_instance" {
  identifier           = "${var.project}-rds-aurora-mysql-rr-01"
  cluster_identifier   = aws_rds_cluster.aurora_mysql_cluster.id
  instance_class       = "db.serverless"
  engine               = aws_rds_cluster.aurora_mysql_cluster.engine
  engine_version       = aws_rds_cluster.aurora_mysql_cluster.engine_version
  db_subnet_group_name = aws_db_subnet_group.aurora_mysql_subnet_group.name
  # db_parameter_group_name = aws_rds_cluster_parameter_group.aurora_mysql_cluster_instance.id
  monitoring_interval = 60
}