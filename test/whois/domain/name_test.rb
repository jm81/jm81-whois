require 'test_helper'

class Whois::Domain::NameTest < Test::Unit::TestCase

  def test_whois  
    assert_whois_data(EXP_DATA)
    assert Whois::Domain.new("notreg123.smith.name").available?
  end

  EXP_DATA = {
    :name => "joe.smith.name",
    :kind => "Name",
    :created_on => "2007-08-08",
    :updated_on => "2009-08-20",
    :expires_on => "2011-08-08",
    :database_updated_at => false,
    :registrar_name => "Tucows Inc.",
    :whois_server => "whois.nic.name",
    :raw_match => "Domain Name: JOE.SMITH.NAME",
    :status => ["clientTransferProhibited", "clientUpdateProhibited"],
    :name_servers => ['NS.123-REG.CO.UK', 'NS2.123-REG.CO.UK']
  }

end
