resource "aws_route53_record" "this" {
  name    = var.name
  records = var.name_servers
  ttl     = "300"
  type    = "NS"
  zone_id = var.ns_zone_id
}
