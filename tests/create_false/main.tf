terraform {
  required_version = "~> 0.11.0"
}

provider aws {
  region = "us-east-1"
}

resource "random_id" "name" {
  byte_length = 6
  prefix      = "terraform-aws-route53-querylog-"
}

module "route53_subzone" {
  source = "../../"

  providers = {
    aws    = "aws"
    aws.ns = "aws"
  }

  create_route53_subzone   = false
  create_route53_query_log = false

  route53_query_log_bucket    = "${random_id.name.hex}"
  route53_query_log_retention = "7"
  subzone_name                = "${random_id.name.hex}"
  root_zone_id                = "nullParent"

  tags = {
    Test = "true"
  }
}
