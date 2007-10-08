require 'test/unit'
require File.join(File.dirname(__FILE__), "..", "test_helper")
require File.join(File.dirname(__FILE__), "..", "..", "lib", "whois")

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
    :raw_match => "Domain name:            registrypro.pro",
    :status => ['serverDeleteProhibited', 'inactive'],
    :name_servers => ['a.gtld.pro', 'a.gtld.pro']
  }
  
end
