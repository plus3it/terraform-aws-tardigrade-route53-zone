resource "random_string" "id" {
  length  = 8
  upper   = false
  special = false
  number  = false
}

resource "aws_route53_zone" "this" {
  name = "${random_string.id.result}.com"
}

resource "aws_s3_bucket" "this" {
  bucket        = "tardigrade-route53-zone-${random_string.id.result}"
  force_destroy = true
}

output "route53_zone" {
  value = aws_route53_zone.this
}

output "bucket" {
  value = aws_s3_bucket.this
}

output "id" {
  value = random_string.id
}
