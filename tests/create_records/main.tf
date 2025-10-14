resource "random_string" "id" {
  length  = 8
  upper   = false
  special = false
  numeric = false
}

module "zone" {
  source = "../..//"

  providers = {
    aws    = aws
    aws.ns = aws
  }

  name = "${random_string.id.result}.com"

  records = {
    "nlb-blue" = {
      name           = "nlb"
      type           = "A"
      ttl            = 300
      records        = ["1.2.3.4", "5.6.7.8"]
      set_identifier = "blue"
      weighted_routing_policy = {
        weight = 100
      }
    }
    "nlb-green" = {
      name           = "nlb"
      type           = "A"
      ttl            = 300
      records        = ["1.2.3.5", "5.6.7.9"]
      set_identifier = "green"
      weighted_routing_policy = {
        weight = 0
      }
    }
  }

  tags = {
    environment = "testing"
  }
}

output "zone" {
  value = module.zone
}
