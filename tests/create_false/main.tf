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
    aws    = aws
    aws.ns = aws
  }

  create_route53_subzone   = false
  create_route53_query_log = false

  tags = {
    Test = "true"
  }
}
