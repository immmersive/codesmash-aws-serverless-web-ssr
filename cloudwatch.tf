resource "aws_cloudwatch_event_rule" "warm_lambda" {
  name                = "${var.app_name}-${terraform.workspace}-cw"
  schedule_expression = "rate(3 minutes)"
}

resource "aws_cloudwatch_event_target" "trigger_lambda" {
  rule      = aws_cloudwatch_event_rule.warm_lambda.name
  arn       = aws_lambda_function.lambda.arn
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.warm_lambda.arn
}
