require 'test_helper'

class Whois::Domain::GovTest < Test::Unit::TestCase

  def test_whois  
    assert_whois_data(EXP_DATA)
    assert Whois::Domain.new("not-reg-1234.gov").available?
  end
  
  def test_register_url
    assert_equal "http://www.dotgov.gov/help_how.aspx", Whois::Domain.new("not-reg-1234.gov").register_url
  end

  EXP_DATA = {
    :name => "dotgov.gov",
    :kind => "Gov",
    :created_on => nil,
    :updated_on => nil,
    :expires_on => nil,
    :database_updated_at => false,
    :registrar_name => nil,
    :whois_server => "whois.nic.gov",
    :raw_match => "Domain Name: dotgov.gov",
    :status => ['Active'],
    :name_servers => []
  }

end
