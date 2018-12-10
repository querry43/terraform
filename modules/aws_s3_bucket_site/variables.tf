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
  type = list(string)
  default = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
}

variable cached_methods {
  type = list(string)
  default = ["GET", "HEAD"]
}

variable compress {
  default = true
}

variable policy {
  default = "allow-all"
}

variable default_root_object {
  default = "index.html"
}

variable price_class {
  default = "PriceClass_100"
}
