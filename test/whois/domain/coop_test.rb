require 'test_helper'

class Whois::Domain::CoopTest < Test::Unit::TestCase

  def test_coop
    assert_whois_data(EXP_COOP)
    assert Whois::Domain.new("not-reg-0987.coop").available?
  end
  
  def test_register_url
    assert_equal "http://domains.coop/", Whois::Domain.new("domains.coop").register_url
  end

  EXP_COOP = {
    :name => "domains.coop",
    :kind => "Coop",
    :created_on => "2002-07-09",
    :updated_on => "2007-01-17",
    :expires_on => "2011-07-09",
    :database_updated_at => false,
    :registrar_name => "domains.coop",
    :whois_server => "whois.nic.coop",
    :raw_match => "Domain Name:             domains.coop",
    :status => ['ok'],
    :name_servers => ['ns2.mydyndns.org', 'ns3.mydyndns.org', 'ns4.mydyndns.org', 'ns5.mydyndns.org', 'ns1.mydyndns.org']
  }
  
end
