data "aws_s3_object" "lambda_zip" {
  bucket = aws_s3_bucket.s3_web.bucket
  key    = "lambda.zip"

  depends_on = [aws_s3_bucket_object.lambda_zip_object] 
}