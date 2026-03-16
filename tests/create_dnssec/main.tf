resource "random_string" "id" {
  length  = 8
  upper   = false
  special = false
  numeric = false
}

module "zone" {
  source = "../../"

  providers = {
    aws    = aws
    aws.ns = aws
  }

  name = "${random_string.id.result}.com"

  tags = {
    Environment = "testing"
    Purpose     = "dnssec-test"
  }
}

module "dnssec" {
  source = "../../modules/dnssec"

  zone_id  = module.zone.id
  ksk_name = "${random_string.id.result}-ksk"

  create_kms_key = true
  kms_key_alias  = "route53-dnssec-${random_string.id.result}"

  tags = {
    Environment = "testing"
  }
}

output "zone" {
  description = "Test zone outputs"
  value       = module.zone
}

output "dnssec" {
  description = "DNSSEC module outputs"
  value       = module.dnssec
}
