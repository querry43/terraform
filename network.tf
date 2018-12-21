resource aws_vpc main {
  cidr_block                       = "10.0.0.0/16"
  assign_generated_ipv6_cidr_block = true
}

resource aws_subnet dmz {
  vpc_id = aws_vpc.main.id

  cidr_block      = cidrsubnet(aws_vpc.main.cidr_block, 8, 0)
  ipv6_cidr_block = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 1)

  map_public_ip_on_launch          = true
  assign_ipv6_address_on_creation  = true
}

resource aws_internet_gateway main {
  vpc_id = aws_vpc.main.id
}

resource aws_route_table dmz {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  route {
    ipv6_cidr_block  = "::/0"
    gateway_id       = aws_internet_gateway.main.id
  }
}

resource aws_route_table_association dmz {
  subnet_id      = aws_subnet.dmz.id
  route_table_id = aws_route_table.dmz.id
}

resource aws_default_security_group default {
  vpc_id = aws_vpc.main.id
}    
