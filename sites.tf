module www_underdogma_net {
  source  = "git@github.com:querry43/terraform-aws-s3-bucket-site.git"
  name    = "www"
  aliases = [""]
  zone    = aws_route53_zone.zone

  providers = {
    aws.us_east_1 = "aws.us_east_1"
  }
}

module test_underdogma_net {
  source = "git@github.com:querry43/terraform-aws-s3-bucket-site.git"
  name   = "test"
  zone   = aws_route53_zone.zone

  providers = {
    aws.us_east_1 = "aws.us_east_1"
  }
}
