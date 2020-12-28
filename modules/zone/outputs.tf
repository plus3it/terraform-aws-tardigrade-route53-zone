output "id" {
  description = "ID of the Route53 zone"
  value       = aws_route53_zone.this.zone_id
}

output "name" {
  description = "Name of the Route53 zone"
  value       = aws_route53_zone.this.name
}

output "name_servers" {
  description = "List of name servers for the zone"
  value       = flatten(aws_route53_zone.this.name_servers)
}
