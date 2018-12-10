variable name { }

variable zone {
  description = "aws_route53_zone zone object in which to create records"
  type = object({
    name = string
  })
}

locals {
  domain_name = "${var.name}.${replace(var.zone.name, "/.$/", "")}"
}

resource aws_s3_bucket bucket {
  bucket = local.domain_name
  acl    = "public-read"

  website {
    index_document = "index.html"
  }
}

data aws_iam_policy_document policy {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.bucket.arn}/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

resource aws_s3_bucket_policy policy {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.policy.json
}

resource aws_cloudfront_distribution distribution {
  aliases = [
    local.domain_name
  ]

  origin {
    domain_name = aws_s3_bucket.bucket.bucket_regional_domain_name
    origin_id   = "S3-${local.domain_name}"
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "S3-${local.domain_name}"
    compress               = true
    viewer_protocol_policy = "allow-all"

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

  price_class = "PriceClass_100"

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

# resource "aws_route53_record" "A_record" {
#   zone_id = "${var.zone_id}"
#   name    = "test"
#   type    = "A"
# 
#   alias {
#     name                   = "${aws_cloudfront_distribution.distribution.domain_name}"
#     zone_id                = "${aws_cloudfront_distribution.distribution.hosted_zone_id}"
#     evaluate_target_health = false
#   }
# }
# 
# resource "aws_route53_record" "AAAA_record" {
#   zone_id = "${var.zone_id}"
#   name    = "test"
#   type    = "AAAA"
# 
#   alias {
#     name                   = "${aws_cloudfront_distribution.distribution.domain_name}"
#     zone_id                = "${aws_cloudfront_distribution.distribution.hosted_zone_id}"
#     evaluate_target_health = false
#   }
# }
