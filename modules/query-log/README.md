# terraform-aws-tardigrade-route53-zone//modules/query-log

Terraform module to create the query log config for a Route53 Zone.

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
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudwatch_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.firehose](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.firehose_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.firehose_kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.subscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_query_log_bucket"></a> [query\_log\_bucket](#input\_query\_log\_bucket) | Sets the destination bucket for Route53 Query Logs delivered by Kinesis Firehose | `string` | n/a | yes |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | ID of the Route53 zone to configure for query logging | `string` | n/a | yes |
| <a name="input_iam_role_arn_cloudwatch"></a> [iam\_role\_arn\_cloudwatch](#input\_iam\_role\_arn\_cloudwatch) | IAM Role ARN for Cloudwatch service permissions | `string` | `null` | no |
| <a name="input_iam_role_arn_firehose"></a> [iam\_role\_arn\_firehose](#input\_iam\_role\_arn\_firehose) | IAM Role ARN for Firehose service permissions | `string` | `null` | no |
| <a name="input_query_log_bucket_kms_key"></a> [query\_log\_bucket\_kms\_key](#input\_query\_log\_bucket\_kms\_key) | ARN of the KMS Key ID or Alias associated with bucket encryption of `route53_query_log_bucket`. Required if bucket is encrypted and `iam_role_arn_firehose` is `null` | `string` | `null` | no |
| <a name="input_query_log_retention"></a> [query\_log\_retention](#input\_query\_log\_retention) | Specifies the number of days you want to retain log events in the CloudWatch log group. | `number` | `7` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to the query log resources | `map(string)` | `{}` | no |

## Outputs

No outputs.

<!-- END TFDOCS -->
