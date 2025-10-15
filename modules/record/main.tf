resource "aws_route53_record" "this" {

  zone_id = var.record.zone_id
  name    = var.record.name
  type    = var.record.type
  ttl     = var.record.ttl
  records = var.record.records

  set_identifier  = var.record.set_identifier
  health_check_id = var.record.health_check_id

  dynamic "weighted_routing_policy" {
    for_each = var.record.weighted_routing_policy != null ? [var.record.weighted_routing_policy] : []
    content {
      weight = weighted_routing_policy.value.weight
    }
  }

  dynamic "alias" {
    for_each = var.record.alias != null ? [var.record.alias] : []
    content {
      name                   = alias.value.name
      zone_id                = alias.value.zone_id
      evaluate_target_health = alias.value.evaluate_target_health
    }
  }

  dynamic "failover_routing_policy" {
    for_each = var.record.failover_routing_policy != null ? [var.record.failover_routing_policy] : []
    content {
      type = failover_routing_policy.value.type
    }
  }
}
