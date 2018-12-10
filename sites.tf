module www_underdogma_net {
  source  = "./modules/aws_s3_bucket_site"
  name    = "www"
  aliases = ["underdogma.net"]
  zone    = aws_route53_zone.zone
}

resource aws_route53_record A_record {
  zone_id = aws_route53_zone.zone.id
  name    = ""
  type    = "A"

  alias {
    name                   = module.www_underdogma_net.aws_cloudfront_distribution.domain_name
    zone_id                = module.www_underdogma_net.aws_cloudfront_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource aws_route53_record AAAA_record {
  zone_id = aws_route53_zone.zone.id
  name    = ""
  type    = "AAAA"

  alias {
    name                   = module.www_underdogma_net.aws_cloudfront_distribution.domain_name
    zone_id                = module.www_underdogma_net.aws_cloudfront_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

module test_underdogma_net {
  source = "./modules/aws_s3_bucket_site"
  name   = "test"
  zone   = aws_route53_zone.zone
}
