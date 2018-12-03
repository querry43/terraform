resource "aws_s3_bucket" "wrecked_underdogma_net" {
  bucket = "wrecked.underdogma.net"
  acl    = "public-read"

  website = {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket" "www_underdogma_net" {
  bucket = "www.underdogma.net"
  acl    = "public-read"

  website = {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket" "test_underdogma_net" {
  bucket = "test.underdogma.net"
  acl    = "public-read"

  website = {
    index_document = "index.html"
  }
}

resource "aws_route53_record" "test_underdogma_net" {
  zone_id = "${aws_route53_zone.zone.zone_id}"
  name    = "test"
  type    = "A"

  alias {
    name                   = "${aws_s3_bucket.test_underdogma_net.website_domain}"
    zone_id                = "${aws_s3_bucket.test_underdogma_net.hosted_zone_id}"
    evaluate_target_health = false
  }
}
