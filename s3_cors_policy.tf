resource "aws_s3_bucket_cors_configuration" "s3_cors" {
  bucket = aws_s3_bucket.s3_web.id

  cors_rule {
    allowed_headers = ["Authorization"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["https://q0uwripz4k.execute-api.us-east-1.amazonaws.com", "https://d20o4zibu5wyho.cloudfront.net"]
    expose_headers  = ["Access-Control-Allow-Origin"]
  }
}
