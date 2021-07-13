module "zone" {
  source = "../..//"

  providers = {
    aws    = aws
    aws.ns = aws
  }

  create_route53_delegation = true
  create_route53_query_log  = true

  name                     = "${random_string.sub_zone.result}.${random_string.ns_zone.result}.com"
  ns_zone_id               = module.ns_zone.id
  query_log_bucket         = data.terraform_remote_state.prereq.outputs.bucket["bucket"].id
  query_log_bucket_kms_key = data.terraform_remote_state.prereq.outputs.kms.keys[data.terraform_remote_state.prereq.outputs.id].arn

  tags = {
    environment = "testing"
  }
}

module "ns_zone" {
  source = "../..//modules/zone"

  name = "${random_string.ns_zone.result}.com"

  tags = {
    environment = "testing"
  }
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

data "terraform_remote_state" "prereq" {
  backend = "local"
  config = {
    path = "prereq/terraform.tfstate"
  }
}

output "zone" {
  value = module.zone
}
