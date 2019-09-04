provider "aws" {}

provider "aws" {
  alias = "ns"
}

data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  iam_role_create_cloudwatch = "${var.iam_role_arn_cloudwatch == ""}"
  iam_role_create_firehose   = "${var.iam_role_arn_firehose == ""}"

  iam_role_arn_cloudwatch = "${local.iam_role_create_cloudwatch ? join("", aws_iam_role.cloudwatch.*.arn) : var.iam_role_arn_cloudwatch}"
  iam_role_arn_firehose   = "${local.iam_role_create_firehose ? join("", aws_iam_role.firehose.*.arn) : var.iam_role_arn_firehose}"
}

resource "aws_route53_zone" "public" {
  count = "${var.create_route53_subzone ? 1 : 0}"

  name = "${var.subzone_name}"
  tags = "${var.tags}"
}

resource "aws_route53_record" "root_public_ns" {
  count = "${var.create_route53_subzone ? 1 : 0}"

  provider = "aws.ns"

  zone_id = "${var.root_zone_id}"
  name    = "${aws_route53_zone.public.name}"
  type    = "NS"
  ttl     = "300"

  records = [
    "${aws_route53_zone.public.name_servers.0}",
    "${aws_route53_zone.public.name_servers.1}",
    "${aws_route53_zone.public.name_servers.2}",
    "${aws_route53_zone.public.name_servers.3}",
  ]
}

##################################
# ROUTE53 LOGGING CONFIGURATION
##################################

resource "aws_cloudwatch_log_group" "this" {
  count = "${var.create_route53_subzone && var.create_route53_query_log ? 1 : 0}"

  name              = "/aws/route53/${aws_route53_zone.public.zone_id}"
  retention_in_days = "${var.route53_query_log_retention}"
}

data "aws_iam_policy_document" "route53-query-logging-policy" {
  count = "${var.create_route53_subzone && var.create_route53_query_log ? 1 : 0}"

  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["arn:${data.aws_partition.current.partition}:logs:*:*:log-group:/aws/route53/${aws_route53_zone.public.zone_id}:*"]

    principals {
      identifiers = ["route53.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_cloudwatch_log_resource_policy" "this" {
  count = "${var.create_route53_subzone && var.create_route53_query_log ? 1 : 0}"

  policy_document = "${data.aws_iam_policy_document.route53-query-logging-policy.json}"
  policy_name     = "route53-query-logging-policy-${aws_route53_zone.public.zone_id}"
}

resource "aws_route53_query_log" "this" {
  count      = "${var.create_route53_subzone && var.create_route53_query_log ? 1 : 0}"
  depends_on = ["aws_cloudwatch_log_resource_policy.this"]

  cloudwatch_log_group_arn = "${aws_cloudwatch_log_group.this.arn}"
  zone_id                  = "${aws_route53_zone.public.zone_id}"
}

##################################
# FIREHOSE CONFIGURATION
##################################
data "aws_iam_policy_document" "assume_role_firehose" {
  count = "${var.create_route53_subzone && var.create_route53_query_log ? 1 : 0}"

  version = "2012-10-17"

  statement {
    sid    = ""
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals = {
      type        = "Service"
      identifiers = ["firehose.amazonaws.com"]
    }

    condition = {
      test     = "StringEquals"
      variable = "sts:ExternalId"

      values = [
        "${data.aws_caller_identity.current.account_id}",
      ]
    }
  }
}

resource "aws_iam_role" "firehose" {
  count = "${var.create_route53_subzone && var.create_route53_query_log && local.iam_role_create_firehose ? 1 : 0}"
  name  = "${var.iam_role_name_firehose_prefix}-${aws_route53_zone.public.zone_id}"
  tags  = "${var.tags}"

  assume_role_policy = "${data.aws_iam_policy_document.assume_role_firehose.json}"
}

data "aws_iam_policy_document" "firehose_s3_delivery" {
  count = "${var.create_route53_subzone && var.create_route53_query_log ? 1 : 0}"

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
      "arn:${data.aws_partition.current.partition}:s3:::${var.route53_query_log_bucket}",
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
      "arn:${data.aws_partition.current.partition}:s3:::${var.route53_query_log_bucket}/*",
    ]
  }
}

resource "aws_iam_policy" "firehose" {
  count = "${var.create_route53_subzone && var.create_route53_query_log && local.iam_role_create_firehose ? 1 : 0}"

  name   = "${aws_iam_role.firehose.name}"
  policy = "${data.aws_iam_policy_document.firehose_s3_delivery.json}"
}

resource "aws_iam_role_policy_attachment" "firehose" {
  count = "${var.create_route53_subzone && var.create_route53_query_log && local.iam_role_create_firehose ? 1 : 0}"

  role       = "${aws_iam_role.firehose.name}"
  policy_arn = "${aws_iam_policy.firehose.arn}"
}

resource "aws_kinesis_firehose_delivery_stream" "this" {
  count = "${var.create_route53_subzone && var.create_route53_query_log ? 1 : 0}"

  name        = "logs_Route53_${aws_route53_zone.public.zone_id}"
  destination = "extended_s3"
  tags        = "${var.tags}"

  extended_s3_configuration {
    role_arn   = "${local.iam_role_arn_firehose}"
    bucket_arn = "arn:${data.aws_partition.current.partition}:s3:::${var.route53_query_log_bucket}"
    prefix     = "AWSLogs/${data.aws_caller_identity.current.account_id}/route53querylogs/${data.aws_region.current.name}/"
  }
}

##################################
# CLOUDWATCH TO FIREHOSE
##################################

data "aws_iam_policy_document" "cloudwatch" {
  count = "${var.create_route53_subzone && var.create_route53_query_log ? 1 : 0}"

  statement {
    actions = [
      "firehose:DeleteDeliveryStream",
      "firehose:PutRecord",
      "firehose:PutRecordBatch",
      "firehose:UpdateDestination",
    ]

    resources = ["${join("", aws_kinesis_firehose_delivery_stream.this.*.arn)}"]
  }
}

resource "aws_iam_policy" "cloudwatch" {
  count = "${var.create_route53_subzone && var.create_route53_query_log && local.iam_role_create_cloudwatch ? 1 : 0}"

  name   = "${var.iam_role_name_cloudwatch_prefix}-${aws_route53_zone.public.zone_id}"
  policy = "${data.aws_iam_policy_document.cloudwatch.json}"
}

data "aws_iam_policy_document" "assume_role_cloudwatch" {
  count = "${var.create_route53_subzone && var.create_route53_query_log ? 1 : 0}"

  version = "2012-10-17"

  statement {
    actions = [
      "sts:AssumeRole",
    ]

    effect = "Allow"

    principals = {
      type        = "Service"
      identifiers = ["logs.${data.aws_region.current.name}.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "cloudwatch" {
  count = "${var.create_route53_subzone && var.create_route53_query_log && local.iam_role_create_cloudwatch ? 1 : 0}"

  name = "${var.iam_role_name_cloudwatch_prefix}-${aws_route53_zone.public.zone_id}"
  tags = "${var.tags}"

  assume_role_policy = "${data.aws_iam_policy_document.assume_role_cloudwatch.json}"
}

resource "aws_iam_role_policy_attachment" "cloudwatch" {
  count = "${var.create_route53_subzone && var.create_route53_query_log && local.iam_role_create_cloudwatch ? 1 : 0}"

  role       = "${aws_iam_role.cloudwatch.name}"
  policy_arn = "${aws_iam_policy.cloudwatch.arn}"
}

resource "aws_cloudwatch_log_subscription_filter" "this" {
  count = "${var.create_route53_subzone && var.create_route53_query_log ? 1 : 0}"

  name           = "subscription_filter_${aws_route53_zone.public.zone_id}"
  role_arn       = "${local.iam_role_arn_cloudwatch}"
  log_group_name = "${aws_cloudwatch_log_group.this.name}"
  filter_pattern = ""

  destination_arn = "${aws_kinesis_firehose_delivery_stream.this.arn}"
}
