variable "zone_id" {
  description = "ID of the Route53 hosted zone to enable DNSSEC on"
  type        = string
}

variable "create_kms_key" {
  description = "Whether to create a new KMS key for DNSSEC signing. If false, kms_key_arn must be provided"
  type        = bool
  default     = true
}

variable "kms_key_arn" {
  description = "ARN of existing KMS key for DNSSEC signing. Required if create_kms_key is false"
  type        = string
  default     = null
}

variable "kms_key_deletion_window" {
  description = "Duration in days after which the KMS key is deleted after destruction. Must be between 7 and 30 days"
  type        = number
  default     = 30

  validation {
    condition     = var.kms_key_deletion_window >= 7 && var.kms_key_deletion_window <= 30
    error_message = "kms_key_deletion_window must be between 7 and 30 days."
  }
}

variable "kms_key_alias" {
  description = "Alias for the KMS key. Only used if create_kms_key is true"
  type        = string
  default     = null
}

variable "ksk_name" {
  description = "Name of the Key Signing Key (KSK). Must be unique within the hosted zone"
  type        = string
}

variable "signing_status" {
  description = "DNSSEC signing status. Valid Values: 'SIGNING' or 'NOT_SIGNING"
  type        = string
  default     = "SIGNING"

  validation {
    condition     = contains(["SIGNING", "NOT_SIGNING"], var.signing_status)
    error_message = "signing_status must be either 'SIGNING' or 'NOT_SIGNING'."
  }
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
