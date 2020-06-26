provider aws {}

resource aws_route53_zone this {
  count = var.create_route53_zone ? 1 : 0

  name = var.name
  tags = var.tags
}
