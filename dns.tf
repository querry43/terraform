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
      name = ""
      type = "TXT"
      records = [
        "v=spf1 include:spf.messagingengine.com ?all"
      ]
    },
    {
      name = "fm1._domainkey"
      type = "CNAME"
      records = [
        "fm1.underdogma.net.dkim.fmhosted.com"
      ]
    },
    {
      name = "fm2._domainkey"
      type = "CNAME"
      records = [
        "fm2.underdogma.net.dkim.fmhosted.com"
      ]
    },
    {
      name = "fm3._domainkey"
      type = "CNAME"
      records = [
        "fm3.underdogma.net.dkim.fmhosted.com"
      ]
    },
    {
      name = ""
      type = "MX"
      records = [
        "10 in1-smtp.messagingengine.com",
        "20 in2-smtp.messagingengine.com",
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
