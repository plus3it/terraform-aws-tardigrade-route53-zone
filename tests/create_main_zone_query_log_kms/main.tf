module "zone" {
  source = "../..//"

  providers = {
    aws    = aws
    aws.ns = aws
  }

  create_route53_query_log = true

  name                     = "${random_string.id.result}.com"
  query_log_bucket         = data.terraform_remote_state.prereq.outputs.bucket["bucket"].id
  query_log_bucket_kms_key = data.terraform_remote_state.prereq.outputs.kms.keys[data.terraform_remote_state.prereq.outputs.id].arn

  tags = {
    environment = "testing"
  }
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

output "zone" {
  value = module.zone
}
