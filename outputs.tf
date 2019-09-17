# Route53
output "public_zone_id" {
  description = "The ID of the public Route53 Zone"
  value       = join("", aws_route53_zone.public.*.zone_id)
}

output "public_zone_name_servers" {
  description = "List of name servers in the public delegation set"
  value       = flatten(aws_route53_zone.public.*.name_servers)
}

