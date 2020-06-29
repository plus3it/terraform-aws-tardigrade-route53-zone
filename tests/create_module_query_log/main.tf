provider aws {
  region = "us-east-1"
}

data "terraform_remote_state" "prereq" {
  backend = "local"
  config = {
    path = "prereq/terraform.tfstate"
  }
}

module "query_log" {
  source = "../..//modules/query-log"

  providers = {
    aws = aws
  }

  create_route53_query_log = true

  query_log_bucket = data.terraform_remote_state.prereq.outputs.bucket.id
  zone_id          = data.terraform_remote_state.prereq.outputs.route53_zone.id

  tags = {
    environment = "testing"
  }
}
