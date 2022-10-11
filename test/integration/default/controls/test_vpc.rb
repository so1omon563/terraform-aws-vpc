# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require './test/library/common'

tfstate = StateFileReader.new

vpc_id = tfstate.read['outputs']['vpc']['value']['vpc_id'].to_s
igw_id = tfstate.read['outputs']['vpc']['value']['vpc']['igw_id'].to_s
eigw_id = tfstate.read['outputs']['vpc']['value']['vpc']['eigw_id'].to_s
private_nacl = tfstate.read['outputs']['vpc']['value']['private_nacl']['id'].to_s
public_nacl = tfstate.read['outputs']['vpc']['value']['public_nacl']['id'].to_s
dhcp_options_id = tfstate.read['outputs']['vpc']['value']['dhcp_options_id'].to_s

control 'default' do
  describe aws_vpc(vpc_id) do
    it { should exist }
    it { should be_available }
    it { should be_default_instance }
    its('cidr_block') { should eq '10.255.255.192/26' }
    its('ipv_6_cidr_block_association_set') { should be_empty }
    its('dhcp_options_id') { should eq dhcp_options_id }
    its('is_default') { should eq false }
    its('tags') do
      should include('environment' => 'dev',
                     'terraform' => 'true',
                     'kitchen' => 'true',
                     'example' => 'true')
    end
  end

  describe aws_internet_gateway(id: igw_id) do
    it { should exist }
    its('vpc_id') { should eq vpc_id }
    it { should be_attached }

    its('tags') do
      should include('environment' => 'dev',
                     'terraform' => 'true',
                     'kitchen' => 'true',
                     'example' => 'true')
    end
  end

  # # There is no inspec-aws eigw resource, resort to raw rspec
  describe 'egress-only intenet gateway' do
    it 'ID is empty' do
      expect(eigw_id).to be_empty
    end
  end

  tfstate.read['outputs']['vpc']['value']['public_route_table_ids'].each do |t|
    describe aws_route_table(route_table_id: t) do
      it { should exist }
      its('vpc_id') { should eq vpc_id }
      its('propagating_vgws') { should be_empty }
      its('routes.count') { should eq 2 }
      its('routes.first.destination_cidr_block') { should eq '10.255.255.192/26' }
      its('routes.first.gateway_id') { should eq 'local' }
      its('routes.first.state') { should eq 'active' }
      its('routes.first.origin') { should eq 'CreateRouteTable' }
      its('routes.last.destination_cidr_block') { should eq '0.0.0.0/0' }
      its('routes.last.gateway_id') { should eq igw_id }
      its('routes.last.state') { should eq 'active' }
      its('routes.last.origin') { should eq 'CreateRoute' }

      its('associations.count') { should eq 2 }

      tfstate.read['outputs']['vpc']['value']['public_subnets'].each do |s|
        it { should have_subnet_associated(s['id']) }
      end

      its('tags') do
        should include('environment' => 'dev',
                       'terraform' => 'true',
                       'kitchen' => 'true',
                       'example' => 'true')
      end
    end
  end

  tfstate.read['outputs']['vpc']['value']['public_subnets'].each do |s|
    describe aws_subnet(s['id']) do
      it { should exist }
      its('vpc_id') { should eq vpc_id }
      it { should be_available }
      its('tags') do
        should include('environment' => 'dev',
                       'terraform' => 'true',
                       'kitchen' => 'true',
                       'example' => 'true',
                       'network' => 'public')
      end

      it { should be_mapping_public_ip_on_launch }
      its('assign_ipv_6_address_on_creation') { should be_falsy }
      its('ipv_6_cidr_block_association_set') { should be_empty }
      its('availability_zone') { should eq s['availability_zone'] }
      its('subnet_arn') { should eq s['arn'] }
    end
  end

  describe aws_network_acl(public_nacl) do
    it { should exist }
    its('vpc_id') { should eq vpc_id }

    tfstate.read['outputs']['vpc']['value']['public_nacl']['subnet_ids'].each do |s|
      its('associated_subnet_ids') { should include s }
    end

    its('tags') do
      should include('environment' => 'dev',
                     'terraform' => 'true',
                     'kitchen' => 'true',
                     'example' => 'true')
    end

    it { should have_ingress }
    it { should have_egress }
    it { should be_associated }

    its('ingress_rule_number_32765.ipv_6_cidr_block') { should eq '::/0' }
    its('ingress_rule_number_32765.protocol') { should eq '-1' }
    its('ingress_rule_number_32765.rule_action') { should eq 'allow' }
    its('ingress_rule_number_32765.port_range.from') { should eq nil }
    its('ingress_rule_number_32765.port_range.to') { should eq nil }

    its('ingress_rule_number_32766.cidr_block') { should eq '0.0.0.0/0' }
    its('ingress_rule_number_32766.protocol') { should eq '-1' }
    its('ingress_rule_number_32766.rule_action') { should eq 'allow' }
    its('ingress_rule_number_32766.port_range.from') { should eq nil }
    its('ingress_rule_number_32766.port_range.to') { should eq nil }

    its('egress_rule_number_32765.ipv_6_cidr_block') { should eq '::/0' }
    its('egress_rule_number_32765.protocol') { should eq '-1' }
    its('egress_rule_number_32765.rule_action') { should eq 'allow' }
    its('egress_rule_number_32765.port_range.from') { should eq nil }
    its('egress_rule_number_32765.port_range.to') { should eq nil }

    its('egress_rule_number_32766.cidr_block') { should eq '0.0.0.0/0' }
    its('egress_rule_number_32766.protocol') { should eq '-1' }
    its('egress_rule_number_32766.rule_action') { should eq 'allow' }
    its('egress_rule_number_32766.port_range.from') { should eq nil }
    its('egress_rule_number_32766.port_range.to') { should eq nil }
  end

  tfstate.read['outputs']['vpc']['value']['private_route_table_ids'].each do |t|
    describe aws_route_table(route_table_id: t) do
      it { should exist }
      its('vpc_id') { should eq vpc_id }
      its('propagating_vgws') { should be_empty }
      its('routes.count') { should eq 2 }
      its('routes.first.destination_cidr_block') { should eq '10.255.255.192/26' }
      its('routes.first.gateway_id') { should eq 'local' }
      its('routes.first.state') { should eq 'active' }
      its('routes.first.origin') { should eq 'CreateRouteTable' }
      its('routes.last.destination_cidr_block') { should eq '0.0.0.0/0' }
      its('routes.last.nat_gateway_id') { should_not eq nil }
      its('routes.last.state') { should eq 'active' }
      its('routes.last.origin') { should eq 'CreateRoute' }

      its('associations.count') { should eq 1 }

      its('tags') do
        should include('environment' => 'dev',
                       'terraform' => 'true',
                       'kitchen' => 'true',
                       'example' => 'true')
      end
    end
  end

  tfstate.read['outputs']['vpc']['value']['private_subnets'].each do |s|
    describe aws_subnet(s['id']) do
      it { should exist }
      its('vpc_id') { should eq vpc_id }
      it { should be_available }
      its('tags') do
        should include('environment' => 'dev',
                       'terraform' => 'true',
                       'kitchen' => 'true',
                       'example' => 'true',
                       'network' => 'private')
      end

      it { should_not be_mapping_public_ip_on_launch }
      its('assign_ipv_6_address_on_creation') { should be_falsy }
      its('ipv_6_cidr_block_association_set') { should be_empty }
      its('availability_zone') { should eq s['availability_zone'] }
      its('subnet_arn') { should eq s['arn'] }
    end
  end

  tfstate.read['outputs']['vpc']['value']['nat_gateways'].each do |g|
    describe aws_nat_gateway(id: g['id']) do
      it { should exist }
      its('state') { should eq 'available' }
      its('vpc_id') { should eq vpc_id }
      its('nat_gateway_address_set') { should include(public_ip: g['public_ip']) }

      its('tags') do
        should include('environment' => 'dev',
                       'terraform' => 'true',
                       'kitchen' => 'true',
                       'example' => 'true')
      end
    end
  end

  describe aws_network_acl(private_nacl) do
    it { should exist }
    its('vpc_id') { should eq vpc_id }

    tfstate.read['outputs']['vpc']['value']['private_nacl']['subnet_ids'].each do |s|
      its('associated_subnet_ids') { should include s }
    end

    its('tags') do
      should include('environment' => 'dev',
                     'terraform' => 'true',
                     'kitchen' => 'true',
                     'example' => 'true')
    end

    it { should have_ingress }
    it { should have_egress }
    it { should be_associated }

    its('ingress_rule_number_32765.ipv_6_cidr_block') { should eq '::/0' }
    its('ingress_rule_number_32765.protocol') { should eq '-1' }
    its('ingress_rule_number_32765.rule_action') { should eq 'allow' }
    its('ingress_rule_number_32765.port_range.from') { should eq nil }
    its('ingress_rule_number_32765.port_range.to') { should eq nil }

    its('ingress_rule_number_32766.cidr_block') { should eq '0.0.0.0/0' }
    its('ingress_rule_number_32766.protocol') { should eq '-1' }
    its('ingress_rule_number_32766.rule_action') { should eq 'allow' }
    its('ingress_rule_number_32766.port_range.from') { should eq nil }
    its('ingress_rule_number_32766.port_range.to') { should eq nil }

    its('egress_rule_number_32765.ipv_6_cidr_block') { should eq '::/0' }
    its('egress_rule_number_32765.protocol') { should eq '-1' }
    its('egress_rule_number_32765.rule_action') { should eq 'allow' }
    its('egress_rule_number_32765.port_range.from') { should eq nil }
    its('egress_rule_number_32765.port_range.to') { should eq nil }

    its('egress_rule_number_32766.cidr_block') { should eq '0.0.0.0/0' }
    its('egress_rule_number_32766.protocol') { should eq '-1' }
    its('egress_rule_number_32766.rule_action') { should eq 'allow' }
    its('egress_rule_number_32766.port_range.from') { should eq nil }
    its('egress_rule_number_32766.port_range.to') { should eq nil }
  end
end

# rubocop:enable Metrics/BlockLength
