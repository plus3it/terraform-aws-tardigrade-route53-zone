# terraform-aws-tardigrade-route53-zone

This terraform module manages a Route53 zone, optionally including the query
log configuration, and the name server delegation record if it is a "subzone."

In order to support cross-account delegations, this module requires two aws
providers. The default `aws` provider will manage the Route53 zone, and the
aliased `aws.ns` provider with credentials to `ns_zone_id` will manage the
delegation records. You must pass both the `aws` and `aws.ns` providers even
if you are not using the subzone delegation option, in which case you can
simply pass the same provider to both `aws` and `aws.ns`.

## Testing

Manual testing:

```
# Replace "xxx" with an actual AWS profile, then execute the integration tests.
export AWS_PROFILE=xxx 
make terraform/pytest PYTEST_ARGS="-v --nomock"
```

For automated testing, PYTEST_ARGS is optional and no profile is needed:

```
make terraform/pytest PYTEST_ARGS="-v"
```

<!-- BEGIN TFDOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

## Providers

No providers.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Name of the zone | `string` | n/a | yes |
| <a name="input_create_route53_delegation"></a> [create\_route53\_delegation](#input\_create\_route53\_delegation) | Controls whether to create Route53 delegation records in the `ns_zone_id`. Provider `aws.ns` is used to create the records | `bool` | `false` | no |
| <a name="input_create_route53_query_log"></a> [create\_route53\_query\_log](#input\_create\_route53\_query\_log) | Controls whether to create a Route53 query log configuration | `bool` | `false` | no |
| <a name="input_iam_role_arn_cloudwatch"></a> [iam\_role\_arn\_cloudwatch](#input\_iam\_role\_arn\_cloudwatch) | IAM Role ARN for Cloudwatch service permissions | `string` | `null` | no |
| <a name="input_iam_role_arn_firehose"></a> [iam\_role\_arn\_firehose](#input\_iam\_role\_arn\_firehose) | IAM Role ARN for Firehose service permissions | `string` | `null` | no |
| <a name="input_ns_zone_id"></a> [ns\_zone\_id](#input\_ns\_zone\_id) | Zone ID of the name server zone. Delegation records for the sub-zone will be created here. Provider `aws.ns` is used to create the records | `string` | `null` | no |
| <a name="input_query_log_bucket"></a> [query\_log\_bucket](#input\_query\_log\_bucket) | Sets the destination bucket for Route53 Query Logs delivered by Kinesis Firehose | `string` | `null` | no |
| <a name="input_query_log_bucket_kms_key"></a> [query\_log\_bucket\_kms\_key](#input\_query\_log\_bucket\_kms\_key) | ARN of the KMS Key ID or Alias associated with bucket encryption of `route53_query_log_bucket`. Required if bucket is encrypted and `iam_role_arn_firehose` is `null` | `string` | `null` | no |
| <a name="input_query_log_retention"></a> [query\_log\_retention](#input\_query\_log\_retention) | Specifies the number of days you want to retain log events in the CloudWatch log group. | `number` | `7` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to the Route53 zone and other resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | ID of the Route53 zone |
| <a name="output_name"></a> [name](#output\_name) | Name of the Route53 zone |
| <a name="output_name_servers"></a> [name\_servers](#output\_name\_servers) | List of name servers for the zone |

<!-- END TFDOCS -->
