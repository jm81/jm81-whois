require 'test/unit'
require File.join(File.dirname(__FILE__), "..", "test_helper")
require File.join(File.dirname(__FILE__), "..", "..", "lib", "whois")

class Whois::Domain::NameTest < Test::Unit::TestCase

  def test_whois  
    assert_whois_data(EXP_DATA)
    assert Whois::Domain.new("notreg123.smith.name").available?
  end

  EXP_DATA = {
    :name => "john.smith.name",
    :kind => "Name",
    :created_on => "2002-01-23",
    :updated_on => "2007-03-19",
    :expires_on => "2008-01-29",
    :database_updated_at => false,
    :registrar_name => "eNom, Inc.",
    :whois_server => "whois.nic.name",
    :raw_match => "Domain Name: JOHN.SMITH.NAME",
    :status => ['ok'],
    :name_servers => ['NS1.MYDOMAIN.COM', 'NS2.MYDOMAIN.COM', 'NS3.MYDOMAIN.COM', 'NS4.MYDOMAIN.COM']
  }

end
