require 'test_helper'

class Whois::Domain::WsTest < Test::Unit::TestCase

  def test_whois
    assert_whois_data(EXP_WS)
    assert Whois::Domain.new("not-reg-1234.ws").available?
  end

  EXP_WS = {
    :name => "example.ws",
    :kind => "Ws",
    :created_on => "2003-07-13",
    :updated_on => "2009-07-03",
    :expires_on => "2010-07-13",
    :database_updated_at => false,
    :registrar_name => "GoDaddy.com",
    :whois_server => "whois.godaddy.com",
    :raw_match => "Domain Name: EXAMPLE.WS",
    :status => [],
    :name_servers => ['ns1.activeaudience.com', 'ns2.activeaudience.com']
  }

end
