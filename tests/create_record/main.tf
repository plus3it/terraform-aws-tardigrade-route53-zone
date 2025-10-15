resource "random_string" "id" {
  length  = 8
  upper   = false
  special = false
  numeric = false
}

resource "aws_route53_health_check" "test" {
  fqdn              = "example.com"
  port              = 443
  type              = "HTTPS"
  resource_path     = "/health"
  failure_threshold = 3
  request_interval  = 30

  tags = {
    environment = "testing"
  }
}

module "zone" {
  source = "../../"

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
    "test_with_health_check" = {
      name            = "api"
      type            = "A"
      ttl             = 300
      records         = ["3.0.2.1"]
      health_check_id = aws_route53_health_check.test.id
      set_identifier  = "primary"
      weighted_routing_policy = {
        weight = 100
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

output "records" {
  value = module.zone.records
}
