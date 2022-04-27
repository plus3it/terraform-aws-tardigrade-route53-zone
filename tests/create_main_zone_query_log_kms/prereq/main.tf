locals {
  id = "tardigrade-test-r53-query-logs-${local.test_id}"

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
  source = "git::https://github.com/plus3it/terraform-aws-tardigrade-kms.git?ref=2.0.0"

  keys = local.keys
}

module "bucket" {
  source = "git::https://github.com/plus3it/terraform-aws-tardigrade-s3-bucket.git?ref=5.0.0"

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

locals {
  random_id = substr(md5(data.null_data_source.id.random), 0, 8)

  test_id = try(null_resource.id.triggers.id, local.random_id)
}

data "null_data_source" "id" {}

resource "null_resource" "id" {
  triggers = {
    id = local.random_id
  }

  lifecycle {
    ignore_changes = [
      triggers,
    ]
  }
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
