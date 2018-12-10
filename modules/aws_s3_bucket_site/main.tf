locals {
  domain_name = "${var.name}.${replace(var.zone.name, "/.$/", "")}"
  origin_id   = "S3-${var.name}.${replace(var.zone.name, "/.$/", "")}"
}
