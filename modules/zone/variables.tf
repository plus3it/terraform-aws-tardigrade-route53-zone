variable "name" {
  description = "Name of the zone to create"
  type        = string
}

variable "tags" {
  description = "Map of tags to apply to the Route53 zone"
  type        = map(string)
  default     = {}
}

variable "vpcs" {
  description = "List of objects of VPC IDs associate to the Private Hosted Zone. NOTE: At least one VPC object is required to create a Private Hosted Zone"
  type = list(object({
    vpc_id = string
  }))
  default = []
}
