# terraform-aws-tardigrade-route53-zone//modules/zone

Terraform module to create a public Route53 zone.

<!-- BEGIN TFDOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the zone to create | `string` | n/a | yes |
| tags | Map of tags to apply to the Route53 zone | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | ID of the Route53 zone |
| name | Name of the Route53 zone |
| name\_servers | List of name servers for the zone |

<!-- END TFDOCS -->
