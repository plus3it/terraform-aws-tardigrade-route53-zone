# terraform-aws-tardigrade-route53-zone//modules/zone

Terraform module to create a public Route53 zone.

<!-- BEGIN TFDOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.0 |
| <a name="provider_aws.vpc_owner"></a> [aws.vpc\_owner](#provider\_aws.vpc\_owner) | >= 6.0 |

## Resources

| Name | Type |
|------|------|

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC to authorize for association to the Route53 Private Hosted Zone | `string` | n/a | yes |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | ID of the Private Hosted Zone that will be associated to the VPC | `string` | n/a | yes |

## Outputs

No outputs.

<!-- END TFDOCS -->
