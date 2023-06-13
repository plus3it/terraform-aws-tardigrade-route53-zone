variable "vpc_id" {
  description = "ID of the VPC to authorize for association to the Route53 Private Hosted Zone"
  type        = string
}

variable "zone_id" {
  type        = string
  description = "ID of the Private Hosted Zone that will be associated to the VPC"
}
