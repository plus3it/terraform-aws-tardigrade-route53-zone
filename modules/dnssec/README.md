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
| <a name="input_ksk_name"></a> [ksk\_name](#input\_ksk\_name) | Name of the Key Signing Key (KSK). Must be unique within the hosted zone | `string` | n/a | yes |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | ID of the Route53 hosted zone to enable DNSSEC on | `string` | n/a | yes |
| <a name="input_create_kms_key"></a> [create\_kms\_key](#input\_create\_kms\_key) | Whether to create a new KMS key for DNSSEC signing. If false, kms\_key\_arn must be provided | `bool` | `true` | no |
| <a name="input_kms_key_alias"></a> [kms\_key\_alias](#input\_kms\_key\_alias) | Alias for the KMS key. Only used if create\_kms\_key is true | `string` | `null` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | ARN of existing KMS key for DNSSEC signing. Required if create\_kms\_key is false | `string` | `null` | no |
| <a name="input_kms_key_deletion_window"></a> [kms\_key\_deletion\_window](#input\_kms\_key\_deletion\_window) | Duration in days after which the KMS key is deleted after destruction. Must be between 7 and 30 days | `number` | `30` | no |
| <a name="input_signing_status"></a> [signing\_status](#input\_signing\_status) | DNSSEC signing status. Valid Values: 'SIGNING' or 'NOT\_SIGNING | `string` | `"SIGNING"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dnssec_status"></a> [dnssec\_status](#output\_dnssec\_status) | DNSSEC signing status for the hosted zone |
| <a name="output_ds_record"></a> [ds\_record](#output\_ds\_record) | DS record to provide to the parent zone (or parent zone administrator) |
| <a name="output_key_signing_key_id"></a> [key\_signing\_key\_id](#output\_key\_signing\_key\_id) | ID of the Route53 Key Signing Key (KSK) |
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | ARN of the KMS key used for DNSSEC signing |

<!-- END TFDOCS -->
