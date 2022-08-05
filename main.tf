

resource "aws_sns_topic" "topic" {
  name = "topic-name"
}


resource "aws_sns_topic_subscription" "target" {
  for_each  = toset(var.email_list)
  topic_arn = aws_sns_topic.topic.arn
  protocol  = "email"
  endpoint  = each.value
}


resource "aws_cloudwatch_metric_alarm" "gateway_error_rate" {
  alarm_name          = "gateway-errors"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  alarm_description   = "Gateway error rate has exceeded 5%"
  treat_missing_data  = "notBreaching"
  metric_name         = "5XXError"
  namespace           = "AWS/ApiGateway"
  alarm_actions       = [aws_sns_topic.topic.arn]
  period              = 60
  evaluation_periods  = 2
  threshold           = 0.05
  statistic           = "Average"
  unit                = "Count"

  dimensions = {
    ApiName = var.api_name
    Stage = var.stage
  }
}
