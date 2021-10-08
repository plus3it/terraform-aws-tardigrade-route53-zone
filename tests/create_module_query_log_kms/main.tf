module "query_log" {
  source = "../..//modules/query-log"

  query_log_bucket         = data.terraform_remote_state.prereq.outputs.bucket["bucket"].id
  query_log_bucket_kms_key = data.terraform_remote_state.prereq.outputs.kms.keys[data.terraform_remote_state.prereq.outputs.id].arn
  zone_id                  = aws_route53_zone.this.zone_id

  tags = {
    environment = "testing"
  }
}

resource "aws_route53_zone" "this" {
  name = "${random_string.id.result}.com"
}

resource "random_string" "id" {
  length  = 8
  upper   = false
  special = false
  number  = false
}

data "terraform_remote_state" "prereq" {
  backend = "local"
  config = {
    path = "prereq/terraform.tfstate"
  }
}
