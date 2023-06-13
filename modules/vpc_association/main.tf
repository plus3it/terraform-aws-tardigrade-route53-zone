resource "aws_route53_vpc_association_authorization" "this" {
  vpc_id  = var.vpc_id
  zone_id = var.zone_id
}

resource "aws_route53_zone_association" "this" {
  provider = aws.vpc_owner

  vpc_id  = aws_route53_vpc_association_authorization.this.vpc_id
  zone_id = aws_route53_vpc_association_authorization.this.zone_id
}
