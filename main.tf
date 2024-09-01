provider "aws" {  
    region     = "us-east-1"
    access_key = ""
    secret_key = ""
}
 
resource "aws_lambda_function" "lambda" {
  function_name = "nextjs-ssr-function"
  role          = aws_iam_role.role.arn
  memory_size   = 256
  timeout       = 10
  handler       = "run.sh"
  runtime       = "nodejs20.x"
  architectures = ["x86_64"]

  s3_bucket = "this-is-for-nextjs-ssr" 
  s3_key    = "lambda.zip" 


  environment {
    variables = {
      AWS_LAMBDA_EXEC_WRAPPER  = "/opt/bootstrap"
      AWS_LWA_ENABLE_COMPRESSION = "true"
      RUST_LOG                = "info"
      PORT                    = "8000"
    }
  }

  layers = [
    "arn:aws:lambda:us-east-1:753240598075:layer:LambdaAdapterLayerX86:23"
  ] 
} 