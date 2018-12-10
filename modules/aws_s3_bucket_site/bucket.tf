resource aws_s3_bucket bucket {
  bucket = local.domain_name
  acl    = "public-read"

  website {
    index_document = "index.html"
  }
}

data aws_iam_policy_document policy {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.bucket.arn}/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

resource aws_s3_bucket_policy policy {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.policy.json
}
