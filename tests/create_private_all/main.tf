provider "aws" {
  profile = "aws"
}

provider "aws" {
  alias   = "vpc_owner"
  profile = "awsalternate"
}

resource "aws_vpc" "test" {
  cidr_block = "10.10.10.0/24"
}

resource "aws_vpc" "test_2" {
  provider = aws.vpc_owner

  cidr_block = "10.10.10.0/24"
}

module "zone" {
  source = "../../modules/zone"

  name = "example.com"

  vpcs = [
    {
      vpc_id = aws_vpc.test.id
    },
  ]

}

module "vpc_association" {
  source = "../../modules/vpc_association"
  providers = {
    aws           = aws
    aws.vpc_owner = aws.vpc_owner
  }

  vpc_id  = aws_vpc.test_2.id
  zone_id = module.zone.id
}

