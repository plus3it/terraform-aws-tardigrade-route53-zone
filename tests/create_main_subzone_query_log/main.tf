module "zone" {
  source = "../..//"

  providers = {
    aws    = aws
    aws.ns = aws
  }

  create_route53_delegation = true
  create_route53_query_log  = true

  name             = "${random_string.sub_zone.result}.${random_string.ns_zone.result}.com"
  ns_zone_id       = module.ns_zone.id
  query_log_bucket = aws_s3_bucket.this.id
}

module "ns_zone" {
  source = "../..//modules/zone"

  name = "${random_string.ns_zone.result}.com"

  tags = {
    environment = "testing"
  }
}

resource "aws_s3_bucket" "this" {
  bucket        = "tardigrade-route53-zone-${random_string.sub_zone.result}"
  force_destroy = true
}

resource "random_string" "ns_zone" {
  length  = 8
  upper   = false
  special = false
  number  = false
}

resource "random_string" "sub_zone" {
  length  = 8
  upper   = false
  special = false
  number  = false
}

output "zone" {
  value = module.zone
}
