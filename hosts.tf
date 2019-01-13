data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["underdogma.net *"]
  }
  owners = ["241824369797"]
}

resource "aws_security_group" "v1" {
  name   = "v1"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_eip" "v1" {
  instance = aws_instance.v1.id
  vpc      = true
}

resource "aws_instance" "v1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  subnet_id = aws_subnet.dmz.id
  vpc_security_group_ids = [
    aws_security_group.v1.id
  ]

  iam_instance_profile = aws_iam_instance_profile.administrator_profile.name

  tags = {
    Name     = "v1.underdogma.net"
    Schedule = "daytime"
  }

  user_data = <<EOF
#cloud-config

hostname: v1
fqdn: v1.underdogma.net

chpasswd:
  list:
    - matt:$6$Ux/U2yRr$kp/I1aa8fp5l2NLqL1OiOMIn7LRW82O803n1B4K8GkgGqY7x4LLWbg7k7H.NusNtDGiPE7uGhfqKX4c2Y06bY0

users:
  - name: matt
    lock_passwd: false
    ssh_authorized_keys: 
    - ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAxnahRdhIq65Mep/6XDaYDpvjFUPwrYZoRqa0B2dtcI+BADxuQV+cmchdJau8gYZdbt066uO70rNfe+WsNXzmox5GVy56cka2XwPQVOQcrp08Qf9vWA96OStK3CfSFwqPY9oHl47yaKedAK7uS47aqjb+0r959RylK8Q8WlRfJw7FDjTWknjnqDOY/WA432d1ZvzJbQeVvAvN+7kLdFIGMUj2ZPVLyIX25xqawp7F7L/HYcrWhsDox/ttN/qcHE5kWhOzfb6ghFfstZ3sgj/MCCspMzQ1B943kWxWnrfe87Lbpl9MaIUnOicilcm+MymNj+DRqMfgE5LATx1ktLgFIw==
EOF
}

module host_dns_records {
  source  = "git@github.com:querry43/terraform-aws-route53-records.git"
  zone    = aws_route53_zone.zone

  recordsets = [
    {
      name = "v1"
      type = "A"
      ttl  = 30
      records = [ aws_eip.v1.public_ip ]
    },
    {
      name = "v1"
      type = "AAAA"
      ttl  = 30
      records = aws_instance.v1.ipv6_addresses
    },
    {
      name = "v8"
      type = "A"
      ttl  = 300
      records = [
        "64.193.62.63"
      ]
    }
  ]
}
