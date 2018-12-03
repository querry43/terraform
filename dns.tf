variable a_records {
  type = "map"

  default = {
    "" = "64.193.62.63"
    "*" = "64.193.62.63"
    "_domainkey" = "64.193.62.63"
    "v7" = "64.193.62.216"
    "v8" = "64.193.62.63"
    "wrecked" = "64.193.62.63"
    "www" = "64.193.62.63"
  }
}

variable cname_records {
  type = "map"

  default = {
    "googleffffffffe7d6dd88" = "google.com."
  }
}

variable txt_records {
  type = "map"

  default = {
    "" = "google-site-verification=rfBuTw5s6j6a8pA9v9iM8Q_5PavyEJAtW83BD_k8g2o"
    "google._domainkey" = "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCB79R0AO54CzSl3+kPHrs8M3zyl3eRwg0ZWWew31MnCEl69YQ7vJpSBCbckZ4sUzLzYcUh+Uh2iMs+G2V/efdnAcX6/2tSuKMlsHQFybiKs+CebqKNjavEpTuqqyWJ2HZciJNAZxG5HCCg973MR5Po85uR6ymrQLDu9FhKn5evBQIDAQAB"
  }
}

variable mx_records {
  type = "list"

  default = [
    "10 aspmx.l.google.com.",
    "20 alt1.aspmx.l.google.com.",
    "20 alt2.aspmx.l.google.com.",
    "30 aspmx2.googlemail.com.",
    "30 aspmx3.googlemail.com.",
    "30 aspmx4.googlemail.com.",
    "30 aspmx5.googlemail.com.",
  ]
}

resource "aws_route53_zone" "zone" {
  name = "underdogma.net"
}

module "a_records" {
  source  = "modules/dns_records"
  zone_id = "${aws_route53_zone.zone.id}"
  records = "${var.a_records}"
}

module "cname_records" {
  source  = "modules/dns_records"
  zone_id = "${aws_route53_zone.zone.id}"
  records = "${var.cname_records}"
  type    = "CNAME"
}

module "txt_records" {
  source  = "modules/dns_records"
  zone_id = "${aws_route53_zone.zone.id}"
  records = "${var.txt_records}"
  type    = "TXT"
}

resource "aws_route53_record" "mx_records" {
  zone_id = "${aws_route53_zone.zone.zone_id}"
  name    = ""
  type    = "MX"
  ttl     = "300"
  records = ["${var.mx_records}"]
}
