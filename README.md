# m-aws-elasticsearch

This repo contains a Terraform module to deploy a VPC-based AWS Elasticsearch domain. Defaults can be altered to fine-tune the deployment. For instance, enforcing node-to-node encryption and https termination on the resulting cluster and kibana endpoints.

## How to use this module:

The module will not run without the following minimum configuration:


<!-- TODO -- MIGRATE THIS TO CUSTOMER REPO AND CHANGE REFERENCE URL -->
```
module "elasticsearch" {
  source                          = "git@github.com:gyant/m-aws-elasticsearch.git"
  vpc_id                          = "${aws_vpc.main.id}"
  domain                          = "test-domain"
  vpc_subnets                     = ["${aws_subnet.a.id}", "${aws_subnet.b.id}", "${aws_subnet.c.id}"]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| vpc_id | A vpc-id to spin up domain in. | string | n/a | yes |
| vpc_subnets | Subnets to launch domain in. | list | n/a | yes |
| vpc_security_groups | Additional domain security groups. | string | n/a | no |
| domain | Name of the domain. | string | n/a | yes |
| es_version | Version of Elasticsearch for domain. | string | 7.1 | yes |
| advanced_options | Advanced options for ES domain. | map | see variables.tf | no |
| instance_type | Instance type for ES nodes. | string | m5.large.elasticsearch | yes |
| instance_count | Number of nodes. | int | 3 | yes |
| dedicated_master_enabled | Enables dedicatd master mode. | bool | true | yes |
| dedicated_master_type | Instance type for master nodes. | string | m5.large.elasticsearch | no |
| dedicated_master_count | Number of master nodes. | int | 3 | no |
| zone_awareness_enabled | Enables Zone Awareness feature. | bool | true | yes |
| availability_zone_count | Sets number of zones for zone awareness. (2 or 3 valid) | int | 3 | no |
| snapshot_start_hour | Sets time of day to run automated snapshots. | string | 23 | yes |
| ebs_enabled | Enabled EBS storage for instances. | bool | true | yes |
| ebs_volume_type | Type of EBS volume for instances. | string | gp2 | no |
| ebs_volume_size | Size (GiB) of EBS volume for instances. | string | 200 | no |
| ebs_volume_iops | Sets IOPS for EBS volumes of type io1. | string | 0 | no |
| encryption_enabled | Enables at-rest encryption. | bool | false | yes |
| kms_key_id | Specifies KMS Key for at-rest encryption. | string | n/a | no |
| node_to_node_encryption_enabled | Enables cross-node communication encryption. | bool | false | yes |
| enforce_https | Enforce HTTPS-only for domain. | bool | false | yes |
| tls_security_policy | Domain's AWS tls security policy. | string | Policy-Min-TLS-1-2-2019-07 | no |
| enable_index_slow_logs | Enables INDEX_SLOW_LOGS. | bool | false | yes |
| enable_search_slow_logs | Enables SEARCH_SLOW_LOGS. | bool | false | yes |
| enable_es_application_logs | Enables ES_APPLICATION_LOGS. | bool | false | yes |
| cloudwatch_log_group_arn | Cloudwatch Log Group for Domain. | string | n/a | no |
| cognito_enabled | Enables cognito auth for Kibana endpoint. | bool | false | yes |
| cognito_user_pool_id | User pool id for Cognito auth. | string | n/a | no |
| cognito_identity_pool_id | Identity pool id for Cognito auth. | string | n/a | no |
| cognito_role_arn | Role for cognito auth. | string | n/a | no |
| domain_admin_policy_identifiers | Admin identities. (Access to ALL http methods on domain) | list | [ "*" ] | yes |
| tags | Map of custom tags to add to domain. | map | n/a | no |

## Outputs

| Name | Description |
|------|-------------|
| arn| The domain arn. |
| domain_id | ID associated with domain. |
| domain_name | Name of domain. |
| endpoint | Elasticsearch cluster endpoint. |
| kibana_endpoint | Kibana dashboard endpoint. |
| domain_azs | Availability zones used by domain. |
| vpc_id | VPC ID domain is deployed to. |
| domain_sg_id | Domain security group id. |
| domain_sg_arn | Domain security group arn. |