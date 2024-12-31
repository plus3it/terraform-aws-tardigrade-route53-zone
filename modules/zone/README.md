# terraform-aws-tardigrade-route53-zone//modules/zone

Terraform module to create a public Route53 zone.

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
| <a name="input_name"></a> [name](#input\_name) | Name of the zone to create | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to apply to the Route53 zone | `map(string)` | `{}` | no |
| <a name="input_vpcs"></a> [vpcs](#input\_vpcs) | List of objects of VPC IDs associate to the Private Hosted Zone. NOTE: At least one VPC object is required to create a Private Hosted Zone | <pre>list(object({<br/>    vpc_id = string<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | ID of the Route53 zone |
| <a name="output_name"></a> [name](#output\_name) | Name of the Route53 zone |
| <a name="output_name_servers"></a> [name\_servers](#output\_name\_servers) | List of name servers for the zone |

<!-- END TFDOCS -->
