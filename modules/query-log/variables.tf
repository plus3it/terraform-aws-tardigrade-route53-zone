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

variable "query_log_bucket" {
  description = "Sets the destination bucket for Route53 Query Logs delivered by Kinesis Firehose"
  type        = string
}

variable "query_log_bucket_kms_key" {
  description = "ARN of the KMS Key ID or Alias associated with bucket encryption of `route53_query_log_bucket`. Required if bucket is encrypted and `iam_role_arn_firehose` is `null`"
  type        = string
  default     = null
}

variable "query_log_retention" {
  description = "Specifies the number of days you want to retain log events in the CloudWatch log group."
  type        = number
  default     = 7
}

variable "tags" {
  description = "A map of tags to add to the query log resources"
  type        = map(string)
  default     = {}
}

variable "zone_id" {
  description = "ID of the Route53 zone to configure for query logging"
  type        = string
}
