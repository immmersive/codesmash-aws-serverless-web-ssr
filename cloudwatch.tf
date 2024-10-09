resource "aws_cloudwatch_event_rule" "warm_lambda" {
  name                = "${var.app_name}-${terraform.workspace}-cw"
  schedule_expression = "rate(3 minutes)"
}

resource "aws_cloudwatch_event_target" "trigger_lambda" {
  rule      = aws_cloudwatch_event_rule.warm_lambda.name
  arn       = aws_lambda_function.lambda.arn
}
