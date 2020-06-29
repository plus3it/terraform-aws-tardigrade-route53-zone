provider aws {}

provider aws {
  alias = "ns"
}

module delegation {
  source = ".//modules/delegation"

  providers = {
    aws = aws.ns
  }

  create_route53_delegation = var.create_route53_delegation
  name                      = module.zone.name
  name_servers              = module.zone.name_servers
  ns_zone_id                = var.ns_zone_id
}

module query_log {
  source = ".//modules/query-log"

  providers = {
    aws = aws
  }

  create_route53_query_log = var.create_route53_query_log
  iam_role_arn_cloudwatch  = var.iam_role_arn_cloudwatch
  iam_role_arn_firehose    = var.iam_role_arn_firehose
  query_log_bucket         = var.query_log_bucket
  query_log_bucket_kms_key = var.query_log_bucket_kms_key
  query_log_retention      = var.query_log_retention
  tags                     = var.tags
  zone_id                  = module.zone.id
}

module zone {
  source = ".//modules/zone"

  providers = {
    aws = aws
  }

  create_route53_zone = var.create_route53_zone
  name                = var.name
  tags                = var.tags
}
