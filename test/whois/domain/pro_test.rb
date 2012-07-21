require 'test_helper'

class Whois::Domain::ProTest < Test::Unit::TestCase
  def test_pro
    assert_whois_data(EXP_PRO)
    assert Whois::Domain.new("not-reg-1234.pro").available?
  end

  def test_register_url
    assert_equal "http://www.registrypro.pro/partners_findaregistrar.htm", Whois::Domain.new("not-reg-1234.pro").register_url
  end

  EXP_PRO = {
    :name => "registrypro.pro",
    :kind => "Pro",
    :created_on => '2004-08-18',
    :updated_on => '2012-06-14',
    :expires_on => '2017-01-26',
    :database_updated_at => false,
    :registrar_name => 'Corporation Service Company dba CSC Corporate Domains, Inc (R2338-PRO)',
    :whois_server => "whois.registrypro.pro",
    :raw_match => "Domain Name:REGISTRYPRO.PRO",
    :status => ['CLIENT TRANSFER PROHIBITED'],
    :name_servers => ['NS1.AMS1.AFILIAS-NST.INFO', 'NS1.MIA1.AFILIAS-NST.INFO', 'NS1.SEA1.AFILIAS-NST.INFO', 'NS1.YYZ1.AFILIAS-NST.INFO', 'NS1.HKG1.AFILIAS-NST.INFO']
  }

end
