resource "aws_s3_bucket" "s3_web" {
  bucket = "${var.app_name}-${terraform.workspace}"
}
