variable create_route53_delegation {
  description = "Controls whether to create Route53 delegation records"
  type        = bool
}

variable name {
  description = "Name of the sub-zone"
  type        = string
}

variable name_servers {
  description = "List of name servers for the sub-zone"
  type        = list(string)
}

variable ns_zone_id {
  description = "Zone ID of the name server zone; delegation records for the sub-zone will be created here"
  type        = string
}
