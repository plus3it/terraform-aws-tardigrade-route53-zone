output "id" {
  description = "ID of the Route53 zone"
  value       = length(module.zone) > 0 ? module.zone.id : null
}

output "name" {
  description = "Name of the Route53 zone"
  value       = length(module.zone) > 0 ? module.zone.name : null
}

output "name_servers" {
  description = "List of name servers for the zone"
  value       = length(module.zone) > 0 ? module.zone.name_servers : null
}

output "record_names" {
  description = "Map of record names"
  value       = try(module.records[0].record_names, null)
}

output "record_fqdns" {
  description = "Map of record FQDNs"
  value       = try(module.records[0].record_fqdns, null)
}
