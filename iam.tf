data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

resource "aws_iam_service_linked_role" "es" {
  aws_service_name = "es.amazonaws.com"
}

data "aws_iam_policy_document" "es-admin" {
  statement {
    effect = "Allow"

    actions = [
      "es:*",
    ]

    principals {
      type        = "AWS"
      identifiers = var.domain_admin_policy_identifiers
    }

    resources = [
      "${aws_elasticsearch_domain.es.arn}/*",
    ]
  }
}

resource "aws_elasticsearch_domain_policy" "es-admin" {
  domain_name = aws_elasticsearch_domain.es.domain_name

  access_policies = data.aws_iam_policy_document.es-admin.json
}
