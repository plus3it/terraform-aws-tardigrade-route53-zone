data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

data "aws_iam_policy_document" "this" {
  count = var.dnssec.kms_key_arn == null ? 1 : 0

  statement {
    sid    = "Enable Root Account Permissions"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }

  statement {
    sid    = "Allow Route 53 DNSSEC Service"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["dnssec-route53.amazonaws.com"]
    }
    actions = [
      "kms:DescribeKey",
      "kms:GetPublicKey",
      "kms:Sign",
    ]
    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
  }

  statement {
    sid    = "Allow Route53 DNSSEC to CreateGrant"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["dnssec-route53.amazonaws.com"]
    }
    actions = [
      "kms:CreateGrant",
    ]
    resources = ["*"]

    condition {
      test     = "Bool"
      variable = "kms:GrantIsForAWSResource"
      values   = ["true"]
    }
  }
}

resource "aws_kms_key" "this" {
  count = var.dnssec.kms_key_arn == null ? 1 : 0

  customer_master_key_spec = "ECC_NIST_P256"
  deletion_window_in_days  = var.dnssec.kms_key_deletion_window
  key_usage                = "SIGN_VERIFY"
  policy                   = data.aws_iam_policy_document.this[0].json
  tags                     = var.dnssec.tags
}

resource "aws_kms_alias" "this" {
  count = var.dnssec.kms_key_arn == null && var.dnssec.kms_key_alias != null ? 1 : 0

  name          = "alias/${var.dnssec.kms_key_alias}"
  target_key_id = aws_kms_key.this[0].key_id
}

resource "aws_route53_key_signing_key" "this" {
  hosted_zone_id             = var.dnssec.zone_id
  key_management_service_arn = var.dnssec.kms_key_arn == null ? aws_kms_key.this[0].arn : var.dnssec.kms_key_arn
  name                       = var.dnssec.ksk_name

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_hosted_zone_dnssec" "this" {
  hosted_zone_id = var.dnssec.zone_id
  signing_status = var.dnssec.signing_status

  depends_on = [
    aws_route53_key_signing_key.this
  ]
}
