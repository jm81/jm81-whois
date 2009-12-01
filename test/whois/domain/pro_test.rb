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
    :created_on => "2004-08-18",
    :updated_on => nil,
    :expires_on => "2016-01-26",
    :database_updated_at => false,
    :registrar_name => "internal",
    :whois_server => "whois.registrypro.pro",
    :raw_match => "Domain Name:REGISTRYPRO.PRO",
    :status => ['serverDeleteProhibited'],
    :name_servers => ['A.GTLD.PRO', 'B.GTLD.PRO', 'C.GTLD.PRO', 'D.GTLD.PRO']
  }
  
end
