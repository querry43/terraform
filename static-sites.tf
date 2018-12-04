module "wrecked_underdogma_net" {
  source = "modules/s3_bucket_site"
  name   = "wrecked.underdogma.net"
}

module "www_underdogma_net" {
  source = "modules/s3_bucket_site"
  name   = "www.underdogma.net"
}

module "test_underdogma_net" {
  source = "modules/s3_bucket_site"
  name   = "test.underdogma.net"
}

resource "aws_route53_record" "test_underdogma_net" {
  zone_id = "${aws_route53_zone.zone.zone_id}"
  name    = "test"
  type    = "A"

  alias {
    name                   = "${module.test_underdogma_net.website_domain}"
    zone_id                = "${module.test_underdogma_net.hosted_zone_id}"
    evaluate_target_health = false
  }
}
