require 'test_helper'

class Whois::Domain::AfiliasTest < Test::Unit::TestCase

  def test_whois  
    assert_whois_data(EXP_DATA)
    assert Whois::Domain.new("not-reg-1234.info").available?
  end

  EXP_DATA = {
    :name => "nic.info",
    :kind => "Afilias",
    :created_on => "2001-07-27",
    :updated_on => "2002-06-10",
    :expires_on => "2011-07-27",
    :database_updated_at => false,
    :registrar_name => "Afilias Ltd. (R145-LRMS)",
    :whois_server => "whois.afilias.net",
    :raw_match => "Domain Name:NIC.INFO",
    :status => ['DELETE PROHIBITED', 'RENEW PROHIBITED', 'TRANSFER PROHIBITED', 'UPDATE PROHIBITED'],
    :name_servers => ['NS01.AFILIAS.INFO', 'NS02.AFILIAS.INFO']
  }

end
