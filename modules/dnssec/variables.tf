variable "dnssec" {
  description = "Configuration for Route53 DNSSEC"
  type = object({
    zone_id                 = string
    kms_key_arn             = optional(string)
    kms_key_alias           = optional(string)
    kms_key_deletion_window = optional(number)
    ksk_name                = string
    signing_status          = optional(string)
    tags                    = optional(map(string))
  })
}
