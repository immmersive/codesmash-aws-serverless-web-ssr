resource "aws_cloudfront_distribution" "cloudfront_web" {

    depends_on = [aws_api_gateway_deployment.api_gateway]
    
    enabled = true
    is_ipv6_enabled = true

    viewer_certificate {
        cloudfront_default_certificate = true
    }

    origin {
        domain_name = "${aws_api_gateway_rest_api.api_gateway.id}.execute-api.${var.region}.amazonaws.com"
        origin_path = "/app"
        origin_id = "origin_1"

        custom_origin_config {
            http_port = 80
            https_port = 443
            origin_protocol_policy = "https-only"
            origin_ssl_protocols = ["TLSv1.2"]
        }
    }

    origin {
        domain_name = "${aws_s3_bucket.s3_web.bucket_regional_domain_name}" 
        origin_id = "origin_2"
        origin_access_control_id = aws_cloudfront_origin_access_control.web_access_control.id
    }

    origin {
        count = var.api != "" ? 1 : 0
        domain_name = "${var.api}" 
        origin_id  = "origin_3"

        custom_origin_config {
          http_port = 80
          https_port = 443
          origin_protocol_policy = "https-only"
          origin_ssl_protocols = ["TLSv1.2"]
        }
    }

    default_cache_behavior {
        allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = "origin_1"

        forwarded_values {
            query_string = true

            cookies {
                forward = "none"
            }
        }

        viewer_protocol_policy  = "redirect-to-https"
        default_ttl             = 0
        min_ttl                 = 0
        max_ttl                 = 0
        compress                = true
    }

    ordered_cache_behavior {
        path_pattern     = "/_next/static/*"
        allowed_methods  = ["GET", "HEAD"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = "origin_2"

        forwarded_values {
            query_string = false

            cookies {
                forward = "none"
            }
        }

        viewer_protocol_policy  = "redirect-to-https"
        default_ttl             = 86400
        min_ttl                 = 0
        max_ttl                 = 31536000
        compress                = true
    }

    ordered_cache_behavior {
        count            = var.api != "" ? 1 : 0
        path_pattern     = "/api/*"
        allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = "origin_3"

        forwarded_values {
            query_string = true
            headers = ["Origin", "Access-Control-Request-Headers", "Access-Control-Request-Method"]

            cookies {
                forward = "none"
              }
        }

        viewer_protocol_policy  = "redirect-to-https"
        default_ttl             = 0
        min_ttl                 = 0
        max_ttl                 = 0
        compress                = true
    }

    price_class = "PriceClass_All"

    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }
}
