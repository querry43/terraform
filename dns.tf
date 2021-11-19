resource aws_route53_zone zone {
  name = "underdogma.net"
}

locals {
  records = [
    {
      name = "_domainkey"
      type = "A"
      records = [
        "64.193.62.63"
      ]
    },
    {
      name = "googleffffffffe7d6dd88"
      type = "CNAME"
      records = [
        "google.com."
      ]
    },
    {
      name = ""
      type = "TXT"
      records = [
        "google-site-verification=rfBuTw5s6j6a8pA9v9iM8Q_5PavyEJAtW83BD_k8g2o"
      ]
    },
    {
      name = "google._domainkey"
      type = "TXT"
      records = [
        "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCB79R0AO54CzSl3+kPHrs8M3zyl3eRwg0ZWWew31MnCEl69YQ7vJpSBCbckZ4sUzLzYcUh+Uh2iMs+G2V/efdnAcX6/2tSuKMlsHQFybiKs+CebqKNjavEpTuqqyWJ2HZciJNAZxG5HCCg973MR5Po85uR6ymrQLDu9FhKn5evBQIDAQAB"
      ]
    },
    {
      name = ""
      type = "MX"
      records = [
        "10 aspmx.l.google.com.",
        "20 alt1.aspmx.l.google.com.",
        "20 alt2.aspmx.l.google.com.",
        "30 aspmx2.googlemail.com.",
        "30 aspmx3.googlemail.com.",
        "30 aspmx4.googlemail.com.",
        "30 aspmx5.googlemail.com.",
      ]
    },
    {
      name = "automation"
      type = "A"
      records = [
        "192.168.50.2",
      ]
    },
    {
      name = "media"
      type = "A"
      records = [
        "192.168.50.77",
      ]
    },
    {
      name = "hubitat"
      type = "A"
      records = [
        "192.168.50.205",
      ]
    }
  ]
}

resource aws_route53_record record {
  for_each = { for record in local.records: "${record.name}.${record.type}" => record }

  zone_id = aws_route53_zone.zone.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 300
  records = each.value.records
}
