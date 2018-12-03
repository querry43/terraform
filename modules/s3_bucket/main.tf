variable "name" {
}

variable "versioning" {
  default = false
}

variable "acl" {
  default = "private"
}

data "aws_kms_key" "key" {
  key_id = "alias/aws/s3"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.name}"
  acl    = "${var.acl}"

  versioning {
    enabled = "${var.versioning}"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${data.aws_kms_key.key.arn}"
        sse_algorithm     = "aws:kms"
      }
    }
  }
}
