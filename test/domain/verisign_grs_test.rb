require 'test/unit'
require File.join(File.dirname(__FILE__), "..", "..", "lib", "whois")

class VerisignGrsTest < Test::Unit::TestCase
  def initialize(*args)
    super
    @com = Whois::Domain.new("example.com")
    @net = Whois::Domain.new("example.net")
  end

  def test_initialize
    assert_kind_of Whois::Domain::VerisignGrs, @com
    assert_kind_of Whois::Domain::VerisignGrs, @net
  end
  
  def test_name
    assert_equal "example.com", @com.name
    assert_equal "example.net", @net.name
  end
  
  def test_dates
    assert_equal Date.parse("2011-08-13").to_s, @com.expires_on.to_s, "expiration date"
    assert_equal Date.parse("1995-08-14").to_s, @com.created_on.to_s, "creation date"
    assert_equal Date.parse("2004-03-26").to_s, @com.updated_on.to_s, "updated date"
    assert_kind_of Time, @com.database_updated_at

    assert_equal Date.parse("2010-08-30").to_s, @net.expires_on.to_s, "expiration date"
    assert_equal Date.parse("1995-08-31").to_s, @net.created_on.to_s, "creation date"
    assert_equal Date.parse("2004-03-26").to_s, @net.updated_on.to_s, "updated date"
    assert_kind_of Time, @net.database_updated_at
  end
  
  def test_status
    assert_kind_of Array, @com.status
    assert_equal ['clientDeleteProhibited', 'clientTransferProhibited', 'clientUpdateProhibited'], @com.status
  end
  
  def test_name_servers
    assert_kind_of Array, @com.name_servers
    assert_equal ['A.IANA-SERVERS.NET', 'B.IANA-SERVERS.NET'], @com.name_servers
    assert_equal @com.name_servers, @com.ns, "ns is an alias for name_servers"
  end
  
  def test_registrar_name
    assert_equal "RESERVED-INTERNET ASSIGNED NUMBERS AUTHORITY", @com.registrar_name
  end
  
  def test_whois_server
    assert_equal "whois.iana.org", @com.whois_server
  end
  
  def test_raw
    assert_kind_of String, @com.raw
    assert_match "Domain Name: EXAMPLE.COM", @com.raw
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
    assert_equal exp, @com.to_s
  end
end
