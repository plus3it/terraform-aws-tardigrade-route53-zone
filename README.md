# terraform-aws-tardigrade-route53-subzone

Terraform module to create a Route53 subzone

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| create\_route53\_query\_log | Controls whether to create the Route53 Query Logging configuration | string | `"true"` | no |
| create\_route53\_query\_log\_iam\_roles | Controls whether to create the IAM Roles for Cloudwatch and Firehose | string | `"true"` | no |
| create\_route53\_subzone | Controls whether to create the Route53 Sub-zone | string | `"true"` | no |
| iam\_role\_arn\_cloudwatch | IAM Role ARN for Cloudwatch service permissions | string | `""` | no |
| iam\_role\_arn\_firehose | IAM Role ARN for Firehose service permissions | string | `""` | no |
| iam\_role\_name\_cloudwatch\_prefix | IAM Role name for CloudWatch Logs service permissions | string | `"service_cloudwatch_target_firehose"` | no |
| iam\_role\_name\_firehose\_prefix | IAM Role name for Kinesis Firehose service permissions | string | `"service_firehose_s3_delivery"` | no |
| root\_zone\_id | Zone ID of the parent zone; delegation records for the subzone will be created here | string | `""` | no |
| route53\_query\_log\_bucket | Sets the destination bucket for Route53 Query Logs delivered by Kinesis Firehose | string | `""` | no |
| route53\_query\_log\_retention | Specifies the number of days you want to retain log events in the specified log group. | string | `"7"` | no |
| subzone\_name | Name of the subzone to create in the parent root zone | string | `""` | no |
| tags | A map of tags to add to the Route53 zones | map | `<map>` | no |

