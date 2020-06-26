# terraform-aws-tardigrade-route53-subzone

Terraform module to create Route53 subzone and and setup delegation for that subzone. This module assumes that you already have a Route53 hosted zone and so this module will simply setup a subzone of that parent zone. The module is also capable of setting up query logging for that subzone but that is disabled by default. If you would like the query logging to be enabled, set the variable `create_route53_query_log` to `true`


<!-- BEGIN TFDOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the zone | `string` | n/a | yes |
| create\_route53\_delegation | Controls whether to create Route53 delegation records in the `ns_zone_id`. Provider `aws.ns` is used to create the records | `bool` | `false` | no |
| create\_route53\_query\_log | Controls whether to create a Route53 query log configuration | `bool` | `false` | no |
| create\_route53\_zone | Controls whether to create the Route53 zone | `bool` | `true` | no |
| iam\_role\_arn\_cloudwatch | IAM Role ARN for Cloudwatch service permissions | `string` | `null` | no |
| iam\_role\_arn\_firehose | IAM Role ARN for Firehose service permissions | `string` | `null` | no |
| ns\_zone\_id | Zone ID of the name server zone. Delegation records for the sub-zone will be created here. Provider `aws.ns` is used to create the records | `string` | `null` | no |
| query\_log\_bucket | Sets the destination bucket for Route53 Query Logs delivered by Kinesis Firehose | `string` | `null` | no |
| query\_log\_bucket\_kms\_key | ARN of the KMS Key ID or Alias associated with bucket encryption of `route53_query_log_bucket`. Required if bucket is encrypted and `iam_role_arn_firehose` is `null` | `string` | `null` | no |
| query\_log\_retention | Specifies the number of days you want to retain log events in the CloudWatch log group. | `number` | `7` | no |
| tags | A map of tags to add to the Route53 zone and other resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | ID of the Route53 zone |
| name | Name of the Route53 zone |
| name\_servers | List of name servers for the zone |

<!-- END TFDOCS -->
