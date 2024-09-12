provider "aws" {
    region     = "us-east-2"
    access_key = ""
    secret_key = ""
}

data "aws_s3_object" "lambda_zip" {
  bucket = "codesmash-aws-serverless-web-ssr"
  key    = "lambda.zip"
}

resource "aws_lambda_function" "lambda" {
  function_name = "nextjs-ssr-function"
  role          = aws_iam_role.role.arn
  memory_size   = 256
  timeout       = 10
  handler       = "run.sh"
  runtime       = "nodejs20.x"
  architectures = ["x86_64"]

  s3_bucket = "codesmash-aws-serverless-web-ssr"
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
    "arn:aws:lambda:us-east-2:753240598075:layer:LambdaAdapterLayerX86:23"
  ]
}
