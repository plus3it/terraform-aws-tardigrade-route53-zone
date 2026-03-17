module "delegation" {
  source = "./modules/delegation"
  count  = var.create_route53_delegation ? 1 : 0

  providers = {
    aws = aws.ns
  }

  name         = module.zone.name
  name_servers = module.zone.name_servers
  ns_zone_id   = var.ns_zone_id
}

module "query_log" {
  source = "./modules/query-log"
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
  source = "./modules/zone"

  name = var.name
  tags = var.tags
  vpcs = var.vpcs
}

module "dnssec" {
  source = "./modules/dnssec"
  count  = var.dnssec != null ? 1 : 0

  dnssec = {
    zone_id                 = module.zone.id
    kms_key_arn             = var.dnssec.kms_key_arn
    kms_key_alias           = var.dnssec.kms_key_alias
    kms_key_deletion_window = var.dnssec.kms_key_deletion_window
    ksk_name                = var.dnssec.ksk_name
    signing_status          = var.dnssec.signing_status
    tags                    = var.dnssec.tags
  }
}

module "record" {
  source   = "./modules/record"
  for_each = var.records

  record = merge(each.value, {
    zone_id = module.zone.id
  })
}
