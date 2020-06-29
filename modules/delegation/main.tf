provider aws {}

resource aws_route53_record this {
  count = var.create_route53_delegation ? 1 : 0

  name    = var.name
  records = var.name_servers
  ttl     = "300"
  type    = "NS"
  zone_id = var.ns_zone_id
}
