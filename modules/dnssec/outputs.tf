output "kms_key_arn" {
  description = "ARN of the KMS key used for DNSSEC signing"
  value       = var.dnssec.kms_key_arn == null ? aws_kms_key.this[0].arn : null
}

output "key_signing_key_id" {
  description = "ID of the Route53 Key Signing Key (KSK)"
  value       = aws_route53_key_signing_key.this.id
}

output "ds_record" {
  description = "DS record to provide to the parent zone (or parent zone administrator)"
  value       = aws_route53_key_signing_key.this.ds_record
}

output "dnssec_status" {
  description = "DNSSEC signing status for the hosted zone"
  value       = aws_route53_hosted_zone_dnssec.this.signing_status
}
