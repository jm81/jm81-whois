require 'test/unit'
require File.join(File.dirname(__FILE__), "..", "..", "lib", "whois")

class VerisignGrsTest < Test::Unit::TestCase
  def setup
    @d = Whois::Domain.new("example.com")
  end

  def test_initialize
    d = Whois::Domain.new("example.com")
    assert_kind_of Whois::Domain::VerisignGrs, d
  end
  
  def test_name
    assert_equal "example.com", @d.name
  end
  
  def test_dates
    assert_equal Date.parse("2011-08-13").to_s, @d.expires_on.to_s, "expiration date"
    assert_equal Date.parse("1995-08-14").to_s, @d.created_on.to_s, "creation date"
    assert_equal Date.parse("2004-03-26").to_s, @d.updated_on.to_s, "updated date"
    assert_kind_of Time, @d.database_updated_at
  end
  
  def test_status
    assert_kind_of Array, @d.status
    assert_equal ['clientDeleteProhibited', 'clientTransferProhibited', 'clientUpdateProhibited'], @d.status
  end
  
  def test_name_servers
    assert_kind_of Array, @d.name_servers
    assert_equal ['A.IANA-SERVERS.NET', 'B.IANA-SERVERS.NET'], @d.name_servers
    assert_equal @d.name_servers, @d.ns, "ns is an alias for name_servers"
  end
  
  def test_registrar_name
    assert_equal "RESERVED-INTERNET ASSIGNED NUMBERS AUTHORITY", @d.registrar_name
  end
  
  def test_whois_server
    assert_equal "whois.iana.org", @d.whois_server
  end
  
  def test_raw
    assert_kind_of String, @d.raw
    assert_match "Domain Name: EXAMPLE.COM", @d.raw
  end
  
  def test_to_s
    exp = <<EOF
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
    assert_equal exp, @d.to_s
  end
end
