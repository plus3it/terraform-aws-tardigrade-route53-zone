# terraform-aws-tardigrade-route53-zone//modules/delegation

Terraform module to create the NS delegation records for a Route53 sub-zone.

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
| <a name="input_name"></a> [name](#input\_name) | Name of the sub-zone | `string` | n/a | yes |
| <a name="input_name_servers"></a> [name\_servers](#input\_name\_servers) | List of name servers for the sub-zone | `list(string)` | n/a | yes |
| <a name="input_ns_zone_id"></a> [ns\_zone\_id](#input\_ns\_zone\_id) | Zone ID of the name server zone; delegation records for the sub-zone will be created here | `string` | n/a | yes |

## Outputs

No outputs.

<!-- END TFDOCS -->
