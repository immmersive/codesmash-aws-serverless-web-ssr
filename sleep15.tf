resource "time_sleep" "sleep15" {
  depends_on = [ aws_s3_bucket.s3_web ]

  create_duration = "15s"
}
