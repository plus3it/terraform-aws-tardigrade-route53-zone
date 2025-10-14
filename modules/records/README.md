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
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |

## Resources

| Name | Type |
|------|------|

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_records"></a> [records](#input\_records) | Map of Route53 records to create | <pre>map(object({<br/>    name           = string<br/>    type           = string<br/>    ttl            = optional(number)<br/>    records        = optional(list(string))<br/>    set_identifier = optional(string)<br/><br/>    weighted_routing_policy = optional(object({<br/>      weight = number<br/>    }))<br/><br/>    alias = optional(object({<br/>      name                   = string<br/>      zone_id                = string<br/>      evaluate_target_health = optional(bool, true)<br/>    }))<br/><br/>    failover_routing_policy = optional(object({<br/>      type = string<br/>    }))<br/>  }))</pre> | n/a | yes |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | Route53 Zone ID | `string` | n/a | yes |

## Outputs

No outputs.

<!-- END TFDOCS -->
