# terraform-aws-tardigrade-route53-zone//modules/delegation

Terraform module to create the NS delegation records for a Route53 sub-zone.

<!-- BEGIN TFDOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the sub-zone | `string` | n/a | yes |
| name\_servers | List of name servers for the sub-zone | `list(string)` | n/a | yes |
| ns\_zone\_id | Zone ID of the name server zone; delegation records for the sub-zone will be created here | `string` | n/a | yes |

## Outputs

No output.

<!-- END TFDOCS -->
