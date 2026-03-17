# terraform-aws-tardigrade-route53-zone//modules/dnssec

Terraform module to configure DNSSEC for a Route53 Zone.

<!-- BEGIN TFDOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.0 |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dnssec"></a> [dnssec](#input\_dnssec) | Configuration for Route53 DNSSEC | <pre>object({<br/>    zone_id                 = string<br/>    kms_key_arn             = optional(string)<br/>    kms_key_alias           = optional(string)<br/>    kms_key_deletion_window = optional(number)<br/>    ksk_name                = string<br/>    signing_status          = optional(string)<br/>    tags                    = optional(map(string))<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dnssec_status"></a> [dnssec\_status](#output\_dnssec\_status) | DNSSEC signing status for the hosted zone |
| <a name="output_ds_record"></a> [ds\_record](#output\_ds\_record) | DS record to provide to the parent zone (or parent zone administrator) |
| <a name="output_key_signing_key_id"></a> [key\_signing\_key\_id](#output\_key\_signing\_key\_id) | ID of the Route53 Key Signing Key (KSK) |
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | ARN of the KMS key used for DNSSEC signing |

<!-- END TFDOCS -->
