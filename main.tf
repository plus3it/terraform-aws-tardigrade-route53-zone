module "delegation" {
  source = ".//modules/delegation"
  count  = var.create_route53_delegation ? 1 : 0

  providers = {
    aws = aws.ns
  }

  name         = module.zone.name
  name_servers = module.zone.name_servers
  ns_zone_id   = var.ns_zone_id
}

module "query_log" {
  source = ".//modules/query-log"
  count  = var.create_route53_query_log ? 1 : 0

  iam_role_arn_cloudwatch  = var.iam_role_arn_cloudwatch
  iam_role_arn_firehose    = var.iam_role_arn_firehose
  query_log_bucket         = var.query_log_bucket
  query_log_bucket_kms_key = var.query_log_bucket_kms_key
  query_log_retention      = var.query_log_retention
  tags                     = var.tags
  zone_id                  = module.zone.id
}

module "zone" {
  source = ".//modules/zone"

  name = var.name
  tags = var.tags
  vpcs = var.vpcs
}

module "records" {
  source = ".//modules/records"
  count  = length(var.records) > 0 ? 1 : 0

  zone_id = module.zone.id
  records = var.records
}


