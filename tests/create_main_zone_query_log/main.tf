module "zone" {
  source = "../..//"

  providers = {
    aws    = aws
    aws.ns = aws
  }

  create_route53_query_log = true

  name             = "${random_string.id.result}.com"
  query_log_bucket = aws_s3_bucket.this.id

  tags = {
    environment = "testing"
  }
}

resource "aws_s3_bucket" "this" {
  bucket        = "tardigrade-route53-zone-${random_string.id.result}"
  force_destroy = true
}

resource "random_string" "id" {
  length  = 8
  upper   = false
  special = false
  number  = false
}

output "zone" {
  value = module.zone
}
