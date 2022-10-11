# Allows for tagging of the default DHCP options set. Duplicates Amazon's default options.

resource "aws_vpc_dhcp_options" "dhcp" {
  domain_name          = "ec2.internal"
  domain_name_servers  = ["AmazonProvidedDNS", ]
  ntp_servers          = []
  netbios_name_servers = []
  netbios_node_type    = ""

  tags = merge(local.tags, { Name = format("%s-default-dhcp-options", var.name) })
}

resource "aws_vpc_dhcp_options_association" "dhcp-vpc" {
  vpc_id          = aws_vpc.vpc.id
  dhcp_options_id = aws_vpc_dhcp_options.dhcp.id
}
