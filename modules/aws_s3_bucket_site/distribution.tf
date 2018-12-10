resource aws_cloudfront_distribution distribution {
  aliases = concat(list(local.domain_name), local.aliases)

  origin {
    domain_name = aws_s3_bucket.bucket.bucket_regional_domain_name
    origin_id   = local.origin_id
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = var.default_root_object

  default_cache_behavior {
    allowed_methods        = var.allowed_methods
    cached_methods         = var.cached_methods
    target_origin_id       = local.origin_id
    compress               = var.compress
    viewer_protocol_policy = var.policy

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  price_class = var.price_class

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.cert.arn
  }
}
