require 'test_helper'

class Whois::Domain::AfiliasTest < Test::Unit::TestCase

  def test_whois
    assert_whois_data(EXP_DATA)
    assert Whois::Domain.new("not-reg-1234.info").available?
  end

  EXP_DATA = {
    :name => "nic.info",
    :kind => "Afilias",
    :created_on => nil,
    :updated_on => nil,
    :expires_on => nil,
    :database_updated_at => false,
    :registrar_name => "Afilias Ltd. (R145-LRMS)",
    :whois_server => "whois.afilias.net",
    :raw_match => "Domain Name:NIC.INFO",
    :status => [],
    :name_servers => ['NS1.AMS1.AFILIAS-NST.INFO', 'NS1.MIA1.AFILIAS-NST.INFO', 'NS1.SEA1.AFILIAS-NST.INFO', 'NS1.YYZ1.AFILIAS-NST.INFO', 'NS1.HKG1.AFILIAS-NST.INFO']
  }

end
