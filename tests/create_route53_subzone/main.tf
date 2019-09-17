provider aws {
  region = "us-east-1"
}

resource "random_string" "root_zone" {
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

resource "aws_route53_zone" "this" {
  name = "${random_string.root_zone.result}.com"
}

module "route53_subzone" {
  source = "../../"

  providers = {
    aws    = "aws"
    aws.ns = "aws"
  }

  create_route53_subzone   = true
  create_route53_query_log = false
  root_zone_id             = aws_route53_zone.this.zone_id
  subzone_name             = "${random_string.sub_zone.result}.${random_string.root_zone.result}.com"

  tags = {
    environment = "testing"
  }
}
