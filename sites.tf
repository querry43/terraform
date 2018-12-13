module www_underdogma_net {
  source  = "./modules/aws_s3_bucket_site"
  name    = "www"
  aliases = [""]
  zone    = aws_route53_zone.zone

  providers = {
    aws.us_east_1 = "aws.us_east_1"
  }
}

module test_underdogma_net {
  source = "./modules/aws_s3_bucket_site"
  name   = "test"
  zone   = aws_route53_zone.zone

  providers = {
    aws.us_east_1 = "aws.us_east_1"
  }
}
