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

  dnssec = {
    ksk_name      = "${random_string.id.result}-ksk"
    kms_key_alias = "route53-dnssec-${random_string.id.result}"
  }

  tags = {
    Environment = "testing"
    Purpose     = "dnssec-test"
  }
}

output "zone" {
  description = "Test zone outputs"
  value       = module.zone
}
