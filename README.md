# terraform-aws-tardigrade-route53-subzone

Terraform module to create Route53 subzone and and setup delegation for that subzone. This module assumes that you already have a Route53 hosted zone and so this module will simply setup a subzone of that parent zone. The module is also capable of setting up query logging for that subzone but that is disabled by default. If you would like the query logging to be enabled, set the variable `create_route53_query_log` to `true`

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| create\_route53\_query\_log | Controls whether to create the Route53 Query Logging configuration | bool | `"false"` | no |
| create\_route53\_subzone | Controls whether to create the Route53 Sub-zone | bool | `"true"` | no |
| iam\_role\_arn\_cloudwatch | IAM Role ARN for Cloudwatch service permissions | string | `"null"` | no |
| iam\_role\_arn\_firehose | IAM Role ARN for Firehose service permissions | string | `"null"` | no |
| iam\_role\_name\_cloudwatch\_prefix | IAM Role name for CloudWatch Logs service permissions | string | `"service_cloudwatch_target_firehose"` | no |
| iam\_role\_name\_firehose\_prefix | IAM Role name for Kinesis Firehose service permissions | string | `"service_firehose_s3_delivery"` | no |
| root\_zone\_id | Zone ID of the parent zone; delegation records for the subzone will be created here | string | `"null"` | no |
| route53\_query\_log\_bucket | Sets the destination bucket for Route53 Query Logs delivered by Kinesis Firehose. Required if `create\_route53\_query\_log` is set to `true` | string | `"null"` | no |
| route53\_query\_log\_retention | Specifies the number of days you want to retain log events in the specified log group. | string | `"7"` | no |
| subzone\_name | Name of the subzone to create in the parent root zone | string | `"null"` | no |
| tags | A map of tags to add to the Route53 zones | map(string) | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| public\_zone\_id | The ID of the public Route53 Zone |
| public\_zone\_name\_servers | List of name servers in the public delegation set |

