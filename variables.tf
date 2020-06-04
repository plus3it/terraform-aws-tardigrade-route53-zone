variable "create_route53_subzone" {
  description = "Controls whether to create the Route53 Sub-zone"
  type        = bool
  default     = true
}

variable "subzone_name" {
  description = "Name of the subzone to create in the parent root zone"
  type        = string
  default     = null
}

variable "root_zone_id" {
  description = "Zone ID of the parent zone; delegation records for the subzone will be created here"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to the Route53 zones"
  type        = map(string)
  default     = {}
}

variable "iam_role_arn_cloudwatch" {
  description = "IAM Role ARN for Cloudwatch service permissions"
  type        = string
  default     = null
}

variable "iam_role_arn_firehose" {
  description = "IAM Role ARN for Firehose service permissions"
  type        = string
  default     = null
}

variable "iam_role_name_cloudwatch_prefix" {
  description = "IAM Role name for CloudWatch Logs service permissions"
  type        = string
  default     = "service_cloudwatch_target_firehose"
}

variable "iam_role_name_firehose_prefix" {
  description = "IAM Role name for Kinesis Firehose service permissions"
  type        = string
  default     = "service_firehose_s3_delivery"
}

variable "create_route53_query_log" {
  description = "Controls whether to create the Route53 Query Logging configuration"
  type        = bool
  default     = false
}

variable "route53_query_log_retention" {
  description = "Specifies the number of days you want to retain log events in the specified log group."
  type        = string
  default     = "7"
}

variable "route53_query_log_bucket" {
  description = "Sets the destination bucket for Route53 Query Logs delivered by Kinesis Firehose. Required if `create_route53_query_log` is set to `true`"
  type        = string
  default     = null
}

variable "route53_query_log_bucket_kms_key" {
  description = "ARN of the KMS Key ID or Alias associated with bucket encryption of `route53_query_log_bucket`. Required if bucket is encrypted and `iam_role_arn_firehose` is `null`"
  type        = string
  default     = null
}
