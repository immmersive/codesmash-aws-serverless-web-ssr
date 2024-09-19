resource "aws_s3_bucket" "s3_web" {
  bucket = "codesmash-ssr-static"

  website {
        index_document = "index.html"
        error_document = "index.html"
    }
}
