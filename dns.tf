resource aws_route53_zone zone {
  name = "underdogma.net"
}

module support_dns_records {
  source = "git@github.com:querry43/terraform-aws-route53-records.git"
  zone   = aws_route53_zone.zone

  recordsets = [
    {
      name = "_domainkey"
      type = "A"
      ttl  = 300
      records = [
        "64.193.62.63"
      ]
    },
    {
      name = "googleffffffffe7d6dd88"
      type = "CNAME"
      ttl  = 300
      records = [
        "google.com."
      ]
    },
    {
      name = ""
      type = "TXT"
      ttl  = 300
      records = [
        "google-site-verification=rfBuTw5s6j6a8pA9v9iM8Q_5PavyEJAtW83BD_k8g2o"
      ]
    },
    {
      name = "google._domainkey"
      type = "TXT"
      ttl  = 300
      records = [
        "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCB79R0AO54CzSl3+kPHrs8M3zyl3eRwg0ZWWew31MnCEl69YQ7vJpSBCbckZ4sUzLzYcUh+Uh2iMs+G2V/efdnAcX6/2tSuKMlsHQFybiKs+CebqKNjavEpTuqqyWJ2HZciJNAZxG5HCCg973MR5Po85uR6ymrQLDu9FhKn5evBQIDAQAB"
      ]
    },
    {
      name = ""
      type = "MX"
      ttl  = 300
      records = [
        "10 aspmx.l.google.com.",
        "20 alt1.aspmx.l.google.com.",
        "20 alt2.aspmx.l.google.com.",
        "30 aspmx2.googlemail.com.",
        "30 aspmx3.googlemail.com.",
        "30 aspmx4.googlemail.com.",
        "30 aspmx5.googlemail.com.",
      ]
    }
  ]
}
