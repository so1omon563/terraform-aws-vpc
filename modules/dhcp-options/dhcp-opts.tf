# VPCs do not support broadcast or multicast traffic, so pin netbios_node_type = 2
# for peer-to-peer (P-node) operation only
resource "aws_vpc_dhcp_options" "dhcp" {
  domain_name          = var.domain_name
  domain_name_servers  = var.domain_name_servers
  ntp_servers          = var.ntp_servers
  netbios_name_servers = var.netbios_name_servers
  netbios_node_type    = 2
  tags                 = merge(local.tags, { Name = format("%s-dhcp-options", var.name) })
}

resource "aws_vpc_dhcp_options_association" "dhcp-vpc" {
  dhcp_options_id = aws_vpc_dhcp_options.dhcp.id
  vpc_id          = var.vpc_id
}
