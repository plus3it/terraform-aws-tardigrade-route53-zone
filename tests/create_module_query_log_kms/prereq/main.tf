provider aws {
  region = "us-east-1"
}

locals {
  # this id cannot use a random_string resource id because the kms module uses
  # for_each on the kms keys object
  id = "tardigrade-test-r53-query-logs"

  keys = [
    {
      alias = local.id
      policy = templatefile(
        "${path.module}/templates/key-policy.json",
        {
          account_id = data.aws_caller_identity.this.account_id,
          bucket     = local.id,
          partition  = data.aws_partition.this.partition,
          region     = data.aws_region.this.name,
        }
      )
    },
  ]
}

module "kms" {
  source = "git::https://github.com/plus3it/terraform-aws-tardigrade-kms.git?ref=0.0.2"

  providers = {
    aws = aws
  }

  create_keys = true
  keys        = local.keys
}

module "bucket" {
  source = "git::https://github.com/plus3it/terraform-aws-tardigrade-s3-bucket.git?ref=4.2.0"

  providers = {
    aws = aws
  }

  bucket        = local.id
  force_destroy = true
  policy = templatefile(
    "${path.module}/templates/bucket-policy.json",
    {
      account_id = data.aws_caller_identity.this.account_id,
      bucket     = local.id,
      partition  = data.aws_partition.this.partition,
    }
  )

  server_side_encryption_configuration = [{
    kms_master_key_id = module.kms.keys[local.id].arn
    sse_algorithm     = "aws:kms"
  }]
}

data "aws_caller_identity" "this" {}
data "aws_region" "this" {}
data "aws_partition" "this" {}

output "id" {
  value = local.id
}

output "bucket" {
  value = module.bucket
}

output "kms" {
  value = module.kms
}
