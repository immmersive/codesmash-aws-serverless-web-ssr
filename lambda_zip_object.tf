resource "aws_s3_bucket_object" "lambda_zip_object" {
  bucket = aws_s3_bucket.s3_web.bucket
  key    = "lambda.zip"
  source = "lambda.zip"
  acl    = "private" 
}