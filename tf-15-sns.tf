resource "aws_sns_topic" "monitoring_notifications" {
  name = "${var.project_id}-pagerduty"
}

resource "aws_sns_topic_policy" "default" {
  arn    = aws_sns_topic.monitoring_notifications.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
    effect  = "Allow"
    actions = ["SNS:Publish"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"
      values   = [data.aws_caller_identity.current.account_id]
    }

    resources = [aws_sns_topic.monitoring_notifications.arn]
  }
}

resource "aws_sns_topic_subscription" "monitoring_subscription" {
  topic_arn = aws_sns_topic.monitoring_notifications.arn
  protocol  = "https"
  endpoint  = "https://events.pagerduty.com/integration/891f0d8b6f6a4e04c0f02210da0b3fe5/enqueue"
}