##################################
# ROUTE53 LOGGING CONFIGURATION
##################################

resource aws_cloudwatch_log_group this {
  name              = "/aws/route53/${var.zone_id}"
  retention_in_days = var.query_log_retention
}

data aws_iam_policy_document cloudwatch {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["arn:${data.aws_partition.current.partition}:logs:*:*:log-group:/aws/route53/${var.zone_id}:*"]

    principals {
      identifiers = ["route53.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource aws_cloudwatch_log_resource_policy this {
  policy_document = data.aws_iam_policy_document.cloudwatch.json
  policy_name     = "query-log-cloudwatch-${var.zone_id}"
}

resource aws_route53_query_log this {
  depends_on = [aws_cloudwatch_log_resource_policy.this]

  cloudwatch_log_group_arn = aws_cloudwatch_log_group.this.arn
  zone_id                  = var.zone_id
}

##################################
# FIREHOSE CONFIGURATION
##################################

data aws_iam_policy_document firehose_assume_role {

  version = "2012-10-17"

  statement {
    sid    = ""
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["firehose.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"

      values = [
        data.aws_caller_identity.current.account_id,
      ]
    }
  }
}

resource aws_iam_role firehose {
  count = local.create_iam_role_firehose ? 1 : 0

  assume_role_policy = data.aws_iam_policy_document.firehose_assume_role.json
  name               = "query-log-firehose-${var.zone_id}"
  tags               = var.tags
}

data aws_iam_policy_document firehose {

  version = "2012-10-17"

  statement {
    sid    = "BucketPermissions"
    effect = "Allow"

    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetBucketLocation",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
    ]

    resources = [
      "arn:${data.aws_partition.current.partition}:s3:::${var.query_log_bucket}",
    ]
  }

  statement {
    sid    = "ObjectPermissions"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:PutObjectAcl",
    ]

    resources = [
      "arn:${data.aws_partition.current.partition}:s3:::${var.query_log_bucket}/*",
    ]
  }
}

resource aws_iam_policy firehose {
  count = local.create_iam_role_firehose ? 1 : 0

  name   = aws_iam_role.firehose[0].name
  policy = data.aws_iam_policy_document.firehose.json
}

resource aws_iam_role_policy_attachment firehose {
  count = local.create_iam_role_firehose ? 1 : 0

  policy_arn = aws_iam_policy.firehose[0].arn
  role       = aws_iam_role.firehose[0].name
}

data aws_iam_policy_document firehose_kms {
  count = local.create_iam_role_firehose && var.query_log_bucket_kms_key != null ? 1 : 0

  version = "2012-10-17"

  statement {
    sid    = "KmsActions"
    effect = "Allow"

    actions = [
      "kms:GenerateDataKey",
    ]

    resources = [
      var.query_log_bucket_kms_key
    ]

    condition {
      test     = "StringEquals"
      variable = "kms:ViaService"

      values = [
        "s3.${data.aws_region.current.name}.amazonaws.com"
      ]
    }

    condition {
      test     = "StringLike"
      variable = "kms:EncryptionContext:aws:s3:arn"

      values = [
        "arn:aws:s3:::${var.query_log_bucket}/*"
      ]
    }
  }
}

resource aws_iam_policy firehose_kms {
  count = local.create_iam_role_firehose && var.query_log_bucket_kms_key != null ? 1 : 0

  name   = "${aws_iam_role.firehose[0].name}-kms"
  policy = data.aws_iam_policy_document.firehose_kms[0].json
}

resource aws_iam_role_policy_attachment firehose_kms {
  count = local.create_iam_role_firehose && var.query_log_bucket_kms_key != null ? 1 : 0

  policy_arn = aws_iam_policy.firehose_kms[0].arn
  role       = aws_iam_role.firehose[0].name
}

resource aws_kinesis_firehose_delivery_stream this {
  destination = "extended_s3"
  name        = "query-log-stream-${var.zone_id}"
  tags        = var.tags

  extended_s3_configuration {
    role_arn   = local.iam_role_arn_firehose
    bucket_arn = "arn:${data.aws_partition.current.partition}:s3:::${var.query_log_bucket}"
    prefix     = "AWSLogs/${data.aws_caller_identity.current.account_id}/route53querylogs/${data.aws_region.current.name}/"
  }
}

#####################################
# CLOUDWATCH SUBSCRIPTION FILTER
#####################################

data aws_iam_policy_document subscription {
  statement {
    actions = [
      "firehose:DeleteDeliveryStream",
      "firehose:PutRecord",
      "firehose:PutRecordBatch",
      "firehose:UpdateDestination",
    ]

    resources = [aws_kinesis_firehose_delivery_stream.this.arn]
  }
}

resource aws_iam_policy subscription {
  count = local.create_iam_role_cloudwatch ? 1 : 0

  name   = "query-log-cloudwatch-${var.zone_id}"
  policy = data.aws_iam_policy_document.subscription.json
}

data aws_iam_policy_document cloudwatch_assume_role {

  version = "2012-10-17"

  statement {
    actions = [
      "sts:AssumeRole",
    ]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["logs.${data.aws_region.current.name}.amazonaws.com"]
    }
  }
}

resource aws_iam_role subscription {
  count = local.create_iam_role_cloudwatch ? 1 : 0

  assume_role_policy = data.aws_iam_policy_document.cloudwatch_assume_role.json
  name               = "query-log-subscription-${var.zone_id}"
  tags               = var.tags
}

resource aws_iam_role_policy_attachment subscription {
  count = local.create_iam_role_cloudwatch ? 1 : 0

  role       = aws_iam_role.subscription[0].name
  policy_arn = aws_iam_policy.subscription[0].arn
}

resource aws_cloudwatch_log_subscription_filter this {
  name           = "query-log-subscription-${var.zone_id}"
  role_arn       = local.iam_role_arn_cloudwatch
  log_group_name = aws_cloudwatch_log_group.this.name
  filter_pattern = ""

  destination_arn = aws_kinesis_firehose_delivery_stream.this.arn
}

##################################
# Data and locals
##################################

data aws_partition current {}

data aws_caller_identity current {}

data aws_region current {}

locals {
  create_iam_role_cloudwatch = var.iam_role_arn_cloudwatch == null
  create_iam_role_firehose   = var.iam_role_arn_firehose == null

  iam_role_arn_cloudwatch = local.create_iam_role_cloudwatch ? join("", aws_iam_role.subscription.*.arn) : var.iam_role_arn_cloudwatch
  iam_role_arn_firehose   = local.create_iam_role_firehose ? join("", aws_iam_role.firehose.*.arn) : var.iam_role_arn_firehose
}
