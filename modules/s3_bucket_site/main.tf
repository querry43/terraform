variable name { }

output website_domain {
  value = "${aws_s3_bucket.bucket.website_domain}"
}

output hosted_zone_id {
  value = "${aws_s3_bucket.bucket.hosted_zone_id}"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.name}"
  acl    = "public-read"

  website = {
    index_document = "index.html"
  }
}

data "aws_iam_policy_document" "policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.bucket.arn}/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_policy" "policy" {
  bucket = "${aws_s3_bucket.bucket.id}"
  policy = "${data.aws_iam_policy_document.policy.json}"
}
