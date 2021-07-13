module "delegation" {
  source = "../..//modules/delegation"

  name         = module.sub_zone.name
  name_servers = module.sub_zone.name_servers
  ns_zone_id   = module.ns_zone.id
}

module "sub_zone" {
  source = "../..//modules/zone"

  name = "${random_string.sub_zone.result}.${random_string.ns_zone.result}.com"

  tags = {
    environment = "testing"
  }
}

module "ns_zone" {
  source = "../..//modules/zone"

  name = "${random_string.ns_zone.result}.com"

  tags = {
    environment = "testing"
  }
}

resource "random_string" "ns_zone" {
  length  = 8
  upper   = false
  special = false
  number  = false
}

resource "random_string" "sub_zone" {
  length  = 8
  upper   = false
  special = false
  number  = false
}
