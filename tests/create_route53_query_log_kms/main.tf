provider aws {
  region = "us-east-1"
}

data "terraform_remote_state" "prereq" {
  backend = "local"
  config = {
    path = "prereq/terraform.tfstate"
  }
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
    aws    = aws
    aws.ns = aws
  }

  create_route53_subzone = true
  root_zone_id           = aws_route53_zone.this.zone_id
  subzone_name           = "${random_string.sub_zone.result}.${random_string.root_zone.result}.com"

  create_route53_query_log         = true
  route53_query_log_bucket         = data.terraform_remote_state.prereq.outputs.bucket["bucket"].id
  route53_query_log_bucket_kms_key = data.terraform_remote_state.prereq.outputs.kms.keys[data.terraform_remote_state.prereq.outputs.id].arn

  tags = {
    environment = "testing"
  }
}
