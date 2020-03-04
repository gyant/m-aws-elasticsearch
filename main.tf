resource "aws_elasticsearch_domain" "es" {
  domain_name           = var.domain
  elasticsearch_version = var.es_version
  advanced_options      = var.advanced_options

  cluster_config {
    instance_type            = var.instance_type
    instance_count           = var.instance_count
    dedicated_master_enabled = var.dedicated_master_enabled
    dedicated_master_type    = var.dedicated_master_type
    dedicated_master_count   = var.dedicated_master_count
    zone_awareness_enabled   = var.zone_awareness_enabled

    zone_awareness_config {
      availability_zone_count = var.availability_zone_count
    }
  }

  snapshot_options {
    automated_snapshot_start_hour = var.snapshot_start_hour
  }

  vpc_options {
    subnet_ids         = var.vpc_subnets
    security_group_ids = concat(list(aws_security_group.es.id), var.vpc_security_groups)
  }

  ebs_options {
    ebs_enabled = var.ebs_enabled
    volume_type = var.ebs_volume_type
    volume_size = var.ebs_volume_size
    iops        = var.ebs_volume_iops
  }

  encrypt_at_rest {
    enabled    = var.encryption_enabled
    kms_key_id = var.kms_key_id
  }

  node_to_node_encryption {
    enabled = var.node_to_node_encryption_enabled
  }

  domain_endpoint_options {
    enforce_https       = var.enforce_https
    tls_security_policy = var.tls_security_policy
  }

  log_publishing_options {
    enabled                  = var.enable_index_slow_logs
    cloudwatch_log_group_arn = var.cloudwatch_log_group_arn
    log_type                 = "INDEX_SLOW_LOGS"
  }

  log_publishing_options {
    enabled                  = var.enable_search_slow_logs
    cloudwatch_log_group_arn = var.cloudwatch_log_group_arn
    log_type                 = "SEARCH_SLOW_LOGS"
  }

  log_publishing_options {
    enabled                  = var.enable_es_application_logs
    cloudwatch_log_group_arn = var.cloudwatch_log_group_arn
    log_type                 = "ES_APPLICATION_LOGS"
  }

  cognito_options {
    enabled          = var.cognito_enabled
    user_pool_id     = var.cognito_user_pool_id
    identity_pool_id = var.cognito_identity_pool_id
    role_arn         = var.cognito_role_arn
  }

  tags = merge(var.tags, local.common_tags)

  depends_on = [
    aws_iam_service_linked_role.es,
  ]
}
