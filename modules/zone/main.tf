resource "aws_route53_zone" "this" {
  name = var.name
  tags = var.tags

  dynamic "vpc" {
    for_each = var.vpcs
    content {
      vpc_id = vpc.value.vpc_id
    }
  }

  lifecycle {
    # Ignore changes to the VPC associations that are made outside of this config.
    # This is necessary in order to support cross-account VPC associations, or
    # other usage of the aws_route53_zone_association resource.
    # See the Terraform docs for more details:
    # * <https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone.html#private-zone>
    # * <https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_vpc_association_authorization>
    ignore_changes = [vpc]
  }
}
