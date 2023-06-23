resource "aws_route53_zone" "this" {
  name = var.name
  tags = var.tags

  dynamic "vpc" {
    for_each = var.vpcs
    content {
      vpc_id = vpc.value.vpc_id
    }
  }
}
