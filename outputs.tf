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

output "records" {
  description = "Map of created records with their details"
  value = {
    for k, v in module.record : k => {
      name = v.name
      fqdn = v.fqdn
    }
  }
}
