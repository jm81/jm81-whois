require 'test_helper'

class Whois::Domain::IntTest < Test::Unit::TestCase

  def test_whois  
    assert_whois_data(EXP_DATA)
    assert Whois::Domain.new("not-reg-1234.int").available?
  end

  EXP_DATA = {
    :name => "un.int",
    :kind => "Int",
    :created_on => "1997-04-23",
    :updated_on => "2006-08-14",
    :expires_on => nil,
    :database_updated_at => false,
    :registrar_name => ".int Domain Registry (IANA)",
    :whois_server => "whois.iana.org",
    :raw_match => "Domain: un.int",
    :status => [],
    :name_servers => ['unhqint1.un.org', 'ns.uu.net']
  }

end
