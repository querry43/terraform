provider aws {
  alias = "us_east_1"
}

variable name {
  description = "name for the site, not including the tld"
}

variable aliases {
  description = "alternate names for the site, including tld"
  type = list(string)
  default = []
}

variable zone {
  description = "aws_route53_zone zone object in which to create records"
  type = object({
    id   = string
    name = string
  })
}

variable allowed_methods {
  description = "aws_cloudfront_distribution allowed_methods"
  type = list(string)
  default = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
}

variable cached_methods {
  description = "aws_cloudfront_distribution cached_methods"
  type = list(string)
  default = ["GET", "HEAD"]
}

variable compress {
  default = true
}

variable policy {
  description = "aws_cloudfront_distribution policy"
  default = "allow-all"
}

variable default_root_object {
  description = "aws_cloudfront_distribution default_root_object"
  default = "index.html"
}

variable price_class {
  description = "aws_cloudfront_distribution price_class"
  default = "PriceClass_100"
}
