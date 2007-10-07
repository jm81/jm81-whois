require 'test/unit'
require File.join(File.dirname(__FILE__), "..", "..", "lib", "whois")

class Whois::Domain::VerisignGrsTest < Test::Unit::TestCase
  def test_com
    assert_whois_data(EXP_COM.merge({:to_s => EXP_COM_TO_S}))
    assert Whois::Domain.new("not-reg-1234.com").available?
  end
  
  def test_net
    assert_whois_data(EXP_NET)
    assert Whois::Domain.new("not-reg-1234.net").available?
  end

  EXP_COM = {
    :name => "example.com",
    :kind => "VerisignGrs",
    :created_on => "1995-08-14",
    :updated_on => "2004-03-26",
    :expires_on => "2011-08-13",
    :registrar_name => "RESERVED-INTERNET ASSIGNED NUMBERS AUTHORITY",
    :whois_server => "whois.iana.org",
    :raw_match => "Domain Name: EXAMPLE.COM",
    :status => ['clientDeleteProhibited', 'clientTransferProhibited', 'clientUpdateProhibited'],
    :name_servers => ['A.IANA-SERVERS.NET', 'B.IANA-SERVERS.NET']
  }
  
  EXP_NET = {
    :name => "example.net",
    :kind => "VerisignGrs",
    :created_on => "1995-08-31",
    :updated_on => "2004-03-26",
    :expires_on => "2010-08-30",
    :registrar_name => "RESERVED-INTERNET ASSIGNED NUMBERS AUTHORITY",
    :whois_server => "whois.iana.org",
    :raw_match => "Domain Name: EXAMPLE.NET",
    :status => ['clientDeleteProhibited', 'clientTransferProhibited', 'clientUpdateProhibited'],
    :name_servers => ['A.IANA-SERVERS.NET', 'B.IANA-SERVERS.NET']
  }
  
  EXP_COM_TO_S = <<EOF
Domain Name: EXAMPLE.COM
Registrar: RESERVED-INTERNET ASSIGNED NUMBERS AUTHORITY
Whois Server: whois.iana.org
Referral URL: http://res-dom.iana.org
Name Server: A.IANA-SERVERS.NET
Name Server: B.IANA-SERVERS.NET
Status: clientDeleteProhibited
Status: clientTransferProhibited
Status: clientUpdateProhibited
Updated Date: 26-mar-2004
Creation Date: 14-aug-1995
Expiration Date: 13-aug-2011
EOF
end
