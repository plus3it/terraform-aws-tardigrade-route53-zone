variable create_route53_zone {
  description = "Controls whether to create the Route53 zone"
  type        = bool
}

variable name {
  description = "Name of the zone to create"
  type        = string
}

variable tags {
  description = "Map of tags to apply to the Route53 zone"
  type        = map(string)
  default     = {}
}
