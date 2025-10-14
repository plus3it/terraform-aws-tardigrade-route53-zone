variable "zone_id" {
  description = "Route53 Zone ID"
  type        = string
}

variable "records" {
  description = "Map of Route53 records to create"
  type = map(object({
    name           = string
    type           = string
    ttl            = optional(number)
    records        = optional(list(string))
    set_identifier = optional(string)

    weighted_routing_policy = optional(object({
      weight = number
    }))

    alias = optional(object({
      name                   = string
      zone_id                = string
      evaluate_target_health = optional(bool, true)
    }))

    failover_routing_policy = optional(object({
      type = string
    }))
  }))
}
