# terraform-aws-tardigrade-route53-zone//modules/records

Terraform module to create records for a Route53 zone.

<!-- BEGIN TFDOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.16.0 |

## Resources

| Name | Type |
|------|------|

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_record"></a> [record](#input\_record) | Route53 record configuration | <pre>object({<br/>    zone_id = string<br/>    name    = string<br/>    type    = string<br/>    ttl     = optional(number)<br/>    records = optional(list(string))<br/><br/>    set_identifier = optional(string)<br/><br/>    weighted_routing_policy = optional(object({<br/>      weight = number<br/>    }))<br/><br/>    failover_routing_policy = optional(object({<br/>      type = string<br/>    }))<br/><br/>    alias = optional(object({<br/>      name                   = string<br/>      zone_id                = string<br/>      evaluate_target_health = optional(bool, false)<br/>    }))<br/><br/>    health_check_id = optional(string)<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_record"></a> [record](#output\_record) | Object of attributes for the Route53 Record |

<!-- END TFDOCS -->
