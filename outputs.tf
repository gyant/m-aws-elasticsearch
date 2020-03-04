output "arn" {
  value = aws_elasticsearch_domain.es.arn
}

output "domain_id" {
  value = aws_elasticsearch_domain.es.domain_id
}

output "domain_name" {
  value = aws_elasticsearch_domain.es.domain_name
}

output "endpoint" {
  value = aws_elasticsearch_domain.es.endpoint
}

output "kibana_endpoint" {
  value = aws_elasticsearch_domain.es.kibana_endpoint
}

output "domain_azs" {
  value = aws_elasticsearch_domain.es.vpc_options.0.availability_zones
}

output "vpc_id" {
  value = aws_elasticsearch_domain.es.vpc_options.0.vpc_id
}

output "domain_sg_id" {
  value = aws_security_group.es.id
}

output "domain_sg_arn" {
  value = aws_security_group.es.arn
}
