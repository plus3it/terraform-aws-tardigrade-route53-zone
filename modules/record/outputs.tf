output "name" {
  description = "The name of the record"
  value       = aws_route53_record.this.name
}

output "fqdn" {
  description = "The FQDN built using zone domain and name"
  value       = aws_route53_record.this.fqdn
}
