resource "aws_s3_bucket_cors_configuration" "s3_cors" {
  bucket = aws_s3_bucket.s3_web.id

  cors_rule {
    allowed_headers = ["Authorization"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["https://${aws_api_gateway_rest_api.api_gateway.id}.execute-api.${var.region}.amazonaws.com", "https://${aws_cloudfront_distribution.cloudfront_web.domain_name}"]
    expose_headers  = ["Access-Control-Allow-Origin"]
  }
}
