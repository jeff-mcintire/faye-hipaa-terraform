resource "aws_opensearch_domain" "hipaa_opensearch" {
  domain_name    = "${var.project}-opensearch"
  engine_version = var.os_engine_version

  cluster_config {
    dedicated_master_count = var.os_master_nodes
    instance_type          = var.os_data_instance_type
    instance_count         = var.os_data_isntance_count
    zone_awareness_enabled = var.os_zone_awareness_enabled
    zone_awareness_config {
      availability_zone_count = var.os_data_isntance_count
    }
  }

  advanced_security_options {
    enabled = false
    # internal_user_database_enabled = true
  }

  encrypt_at_rest {
    enabled = true
  }

  domain_endpoint_options {
    # custom_endpoint                 = "hipaa-search.${var.domain}"
    # custom_endpoint_certificate_arn = data.aws_acm_certificate.fbsghosting.arn
    # custom_endpoint_enabled         = true
    enforce_https       = true
    tls_security_policy = "Policy-Min-TLS-1-0-2019-07"
  }

  ebs_options {
    ebs_enabled = var.os_ebs_enabled
    volume_size = var.os_ebs_volume_size
    volume_type = var.os_volume_type
    throughput  = var.os_throughput
  }

  log_publishing_options {
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.opensearch_log_group_index_slow_logs.arn
    log_type                 = "INDEX_SLOW_LOGS"
  }
  log_publishing_options {
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.opensearch_log_group_search_slow_logs.arn
    log_type                 = "SEARCH_SLOW_LOGS"
  }
  log_publishing_options {
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.opensearch_log_group_es_application_logs.arn
    log_type                 = "ES_APPLICATION_LOGS"
  }

  node_to_node_encryption {
    enabled = true
  }

  vpc_options {
    subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[3]]

    security_group_ids = [aws_security_group.opensearch_security_group.id]
  }


  access_policies = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : "es:*",
          "Principal" : {
            "AWS" : "*"
          },
          "Effect" : "Allow",
          "Resource" : "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.project}-opensearch/*"
        }
      ]
  })
}