module wrecked_underdogma_net {
  source      = "./modules/s3_bucket_site"
  name = "wrecked"
  zone        = aws_route53_zone.zone
}

module www_underdogma_net {
  source      = "./modules/s3_bucket_site"
  name = "www"
  zone        = aws_route53_zone.zone
}

module test_underdogma_net {
  source      = "./modules/s3_bucket_site"
  name = "test"
  zone        = aws_route53_zone.zone
}

module www_dns_records {
  source  = "git@github.com:querry43/terraform-aws-route53-records.git"
  zone    = aws_route53_zone.zone

  recordsets = [
    {
      name = "*"
      type = "A"
      ttl = 300
      records = [
        "64.193.62.63"
      ]
    },
    {
      name = "www"
      type = "A"
      ttl = 300
      records = [
        "64.193.62.63"
      ]
    }
  ]
}

module wrecked_dns_records {
  source  = "git@github.com:querry43/terraform-aws-route53-records.git"
  zone    = aws_route53_zone.zone

  recordsets = [
    {
      name = "wrecked"
      type = "A"
      ttl = 300
      records = [
        "64.193.62.63"
      ]
    }
  ]
}
