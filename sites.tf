module www_underdogma_net {
  source  = "./modules/aws_s3_bucket_site"
  name    = "www"
  aliases = [""]
  zone    = aws_route53_zone.zone
}

module test_underdogma_net {
  source = "./modules/aws_s3_bucket_site"
  name   = "test"
  zone   = aws_route53_zone.zone
}
