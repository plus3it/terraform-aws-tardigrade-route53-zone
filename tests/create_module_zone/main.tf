resource "random_string" "id" {
  length  = 8
  upper   = false
  special = false
  number  = false
}

module "zone" {
  source = "../..//modules/zone"

  name = "${random_string.id.result}.com"

  tags = {
    environment = "testing"
  }
}

output "zone" {
  value = module.zone
}
