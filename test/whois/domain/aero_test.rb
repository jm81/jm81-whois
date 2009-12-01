require 'test_helper'

class Whois::Domain::AeroTest < Test::Unit::TestCase

  def test_whois  
    assert_whois_data(EXP_DATA)
    assert Whois::Domain.new("not-reg-1234.aero").available?
  end

  EXP_DATA = {
    :name => "information.aero",
    :kind => "Aero",
    :created_on => "2002-02-19",
    :updated_on => "2009-02-20",
    :expires_on => "2010-02-19",
    :database_updated_at => false,
    :registrar_name => "SITA (9999)",
    :whois_server => "whois.aero",
    :raw_match => "Domain Name:INFORMATION.AERO",
    :status => ['OK'],
    :name_servers => ['NS01.AFILIAS.INFO', 'NS02.AFILIAS.INFO']
  }

end
