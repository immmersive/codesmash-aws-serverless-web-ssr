resource "aws_lambda_function" "lambda" {
  function_name = "${var.app_name}_${terraform.workspace}"
  role          = aws_iam_role.role.arn
  memory_size   = 256
  timeout       = 10
  handler       = "run.sh"
  runtime       = "nodejs20.x"
  architectures = ["x86_64"]
  publish       = true

  s3_bucket = aws_s3_bucket.s3_web.bucket
  s3_key    = "lambda.zip"

  source_code_hash = data.aws_s3_object.lambda_zip.etag

  environment {
    variables = {
      AWS_LAMBDA_EXEC_WRAPPER  = "/opt/bootstrap"
      AWS_LWA_ENABLE_COMPRESSION = "true"
      RUST_LOG                = "info"
      PORT                    = "8000"
    }
  }

  layers = [
    "arn:aws:lambda:${var.region}:753240598075:layer:LambdaAdapterLayerX86:23"
  ]
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.warm_lambda.arn
}
