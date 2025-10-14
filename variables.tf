variable "create_route53_delegation" {
  description = "Controls whether to create Route53 delegation records in the `ns_zone_id`. Provider `aws.ns` is used to create the records"
  type        = bool
  default     = false
}

variable "create_route53_query_log" {
  description = "Controls whether to create a Route53 query log configuration"
  type        = bool
  default     = false
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

variable "name" {
  description = "Name of the zone"
  type        = string
}

variable "ns_zone_id" {
  description = "Zone ID of the name server zone. Delegation records for the sub-zone will be created here. Provider `aws.ns` is used to create the records"
  type        = string
  default     = null
}

variable "query_log_bucket" {
  description = "Sets the destination bucket for Route53 Query Logs delivered by Kinesis Firehose"
  type        = string
  default     = null
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

variable "records" {
  description = "Map of Route53 records to create"
  type = map(object({
    name           = string
    type           = string
    ttl            = optional(number)
    records        = optional(list(string))
    set_identifier = optional(string)

    weighted_routing_policy = optional(object({
      weight = number
    }))

    alias = optional(object({
      name                   = string
      zone_id                = string
      evaluate_target_health = optional(bool, true)
    }))

    failover_routing_policy = optional(object({
      type = string
    }))
  }))
  default = {}
}

variable "vpcs" {
  description = "List of objects of VPC IDs associate to the Private Hosted Zone. NOTE: At least one VPC object is required to create a Private Hosted Zone"
  type = list(object({
    vpc_id = string
  }))
  default = []
}
variable "tags" {
  description = "A map of tags to add to the Route53 zone and other resources"
  type        = map(string)
  default     = {}
}

variable "zone_id" {
  description = "Existing zone ID to use instead of creating a new zone"
  type        = string
  default     = null
}
