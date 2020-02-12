variable "vpc_id" {}
variable "domain" {}

variable "es_version" {
  default = "7.1"
}

variable "advanced_options" {
  type = "map"

  default = {
    "rest.action.multi.allow_explicit_index" = "true" # This is set by AWS when creating cluster. Causes constant plan diffs if not here.
  }
}

variable "instance_type" {
  default = "m5.large.elasticsearch"
}

variable "instance_count" {
  default = "3"
}

variable "dedicated_master_enabled" {
  default = true
}

variable "dedicated_master_type" {
  default = "m5.large.elasticsearch"
}

variable "dedicated_master_count" {
  default = 3
}

variable "zone_awareness_enabled" {
  default = true
}

variable "availability_zone_count" {
  default = 3
}

variable "snapshot_start_hour" {
  default = "23"
}

variable "vpc_subnets" {
  type = "list"
}

variable "vpc_security_groups" {
  type    = "list"
  default = []
}

variable "ebs_enabled" {
  default = true
}

variable "ebs_volume_type" {
  default = "gp2"
}

variable "ebs_volume_size" {
  default = "200"
}

# For io1 drives only
variable "ebs_volume_iops" {
  default = "0"
}

variable "encryption_enabled" {
  default = false
}

variable "kms_key_id" {
  default = ""
}

variable "node_to_node_encryption_enabled" {
  default = false
}

variable "enforce_https" {
  default = false
}

variable "tls_security_policy" {
  default = "Policy-Min-TLS-1-2-2019-07"
}

variable "enable_index_slow_logs" {
  default = false
}

variable "enable_search_slow_logs" {
  default = false
}

variable "enable_es_application_logs" {
  default = false
}

variable "cloudwatch_log_group_arn" {
  default = ""
}

variable "cognito_enabled" {
  default = false
}

variable "cognito_user_pool_id" {
  default = ""
}

variable "cognito_identity_pool_id" {
  default = ""
}

variable "cognito_role_arn" {
  default = ""
}

variable "domain_policy_identifiers" {
  default = ["*"]
}

variable "tags" {
  default = {}
}

locals {
  common_tags = {
    Domain = "${var.domain}"
  }
}
