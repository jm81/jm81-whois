require 'test_helper'

class Whois::Domain::NameTest < Test::Unit::TestCase

  def test_whois
    assert_whois_data(EXP_DATA)
    assert Whois::Domain.new("notreg123.joe.smith.name").available?
  end

  EXP_DATA = {
    :name => 'stevejobs.name',
    :kind => 'Name',
    :created_on => '2009-09-28',
    :updated_on => '2013-09-29',
    :expires_on => '2014-09-28',
    :database_updated_at => false,
    :registrar_name => "Register.it SPA",
    :whois_server => "whois.nic.name",
    :raw_match => "Domain Name: STEVEJOBS.NAME",
    :status => ['ok'],
    :name_servers => ['NS1.REGISTER.IT', 'NS2.REGISTER.IT']
  }

end
