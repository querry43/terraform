variable zone_id {
}

variable ttl {
  default = 300
}

variable type {
  default = "A"
}

variable records {
  type = "map"
}

resource "aws_route53_record" "records" {
  count = "${length(keys(var.records))}"

  zone_id = "${var.zone_id}"
  name    = "${element(keys(var.records), count.index)}"
  type    = "${var.type}"
  ttl     = "${var.ttl}"
  records = ["${element(values(var.records), count.index)}"]
}
