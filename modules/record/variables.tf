variable "record" {
  description = "Route53 record configuration"
  type = object({
    zone_id = string
    name    = string
    type    = string
    ttl     = optional(number)
    records = optional(list(string))

    set_identifier  = optional(string)
    health_check_id = optional(string)

    weighted_routing_policy = optional(object({
      weight = number
    }))

    failover_routing_policy = optional(object({
      type = string
    }))

    alias = optional(object({
      name                   = string
      zone_id                = string
      evaluate_target_health = optional(bool, false)
    }))
  })
}
