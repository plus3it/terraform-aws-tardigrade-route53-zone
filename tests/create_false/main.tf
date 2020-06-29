provider aws {
  region = "us-east-1"
}

module "route53_subzone" {
  source = "../..//"

  providers = {
    aws    = aws
    aws.ns = aws
  }

  create_route53_zone = false

  name = null
}
