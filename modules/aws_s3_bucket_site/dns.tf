resource aws_route53_record A_records {
  count = length(local.all_names)

  zone_id = var.zone.id
  name    = local.all_names[count.index]
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.distribution.domain_name
    zone_id                = aws_cloudfront_distribution.distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource aws_route53_record AAAA_records {
  count = length(local.all_names)

  zone_id = var.zone.id
  name    = local.all_names[count.index]
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.distribution.domain_name
    zone_id                = aws_cloudfront_distribution.distribution.hosted_zone_id
    evaluate_target_health = false
  }
}
