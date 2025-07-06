output "api_gateway_url" {
  description = "API Gateway endpoint URL"
  value = "https://${aws_api_gateway_rest_api.api_gateway.id}.execute-api.${var.region}.amazonaws.com/${aws_api_gateway_stage.api_stage.stage_name}"
}

output "api_gateway_id" {
    value =  "${aws_api_gateway_rest_api.api_gateway.id}"
}

output "bucket_id" {
    value = "${aws_s3_bucket.s3_web.id}"
}

output "aws_lambda_function" {
    value = aws_lambda_function.lambda.function_name
}

output "cloudfront_id" {
    value = "${aws_cloudfront_distribution.cloudfront_web.id}"
}

output "cloudfront_domain" {
    value = "${aws_cloudfront_distribution.cloudfront_web.domain_name}"
}
