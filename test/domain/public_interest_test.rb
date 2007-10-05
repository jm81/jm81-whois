require 'test/unit'
require File.join(File.dirname(__FILE__), "..", "..", "lib", "whois")

class PublicInterestTest < Test::Unit::TestCase
  ORG = Whois::Domain.new("example.org")

  def setup
    @org = ORG
  end

  def test_initialize
    assert_kind_of Whois::Domain::PublicInterest, @org
  end
  
  def test_name
    assert_equal "example.org", @org.name
  end
  
  def test_dates
    assert_equal Date.parse("2010-08-30").to_s, @org.expires_on.to_s, "expiration date"
    assert_equal Date.parse("1995-08-31").to_s, @org.created_on.to_s, "creation date"
    assert_equal Date.parse("2004-02-18").to_s, @org.updated_on.to_s, "updated date"
    assert_nil @org.database_updated_at
  end
  
  def test_status
    assert_kind_of Array, @org.status
    assert_equal ['DELETE PROHIBITED', 'RENEW PROHIBITED', 'TRANSFER PROHIBITED', 'UPDATE PROHIBITED'], @org.status
  end
  
  def test_name_servers
    assert_kind_of Array, @org.name_servers
    assert_equal ['A.IANA-SERVERS.NET', 'B.IANA-SERVERS.NET'], @org.name_servers
    assert_equal @org.name_servers, @org.ns, "ns is an alias for name_servers"
  end
  
  def test_registrar_name
    assert_equal "Internet Assigned Numbers Authority (IANA) (R193-LROR)", @org.registrar_name
  end
  
  def test_whois_server
    assert_equal "whois.pir.org", @org.whois_server
  end
  
  def test_raw
    assert_kind_of String, @org.raw
    assert_match "Domain Name:EXAMPLE.ORG", @org.raw
  end
  
  def test_to_s
    exp = <<EOF
Domain ID: D2328855-LROR
Domain Name: EXAMPLE.ORG
Created On: 31-Aug-1995 04:00:00 UTC
Last Updated On: 18-Feb-2004 03:48:47 UTC
Expiration Date: 30-Aug-2010 04:00:00 UTC
Sponsoring Registrar: Internet Assigned Numbers Authority (IANA) (R193-LROR)
Status: DELETE PROHIBITED
Status: RENEW PROHIBITED
Status: TRANSFER PROHIBITED
Status: UPDATE PROHIBITED
Registrant ID: IANA
Registrant Name: Internet Assigned Numbers Authority
Registrant Organization: Internet Assigned Numbers Authority (IANA)
Registrant Street1: 4676 Admiralty Way
Registrant Street2: Suite 330
Registrant City: Marina del Rey
Registrant State/Province: CA
Registrant Postal Code: 92092
Registrant Country: US
Registrant Phone: +1.3108239358
Registrant FAX: +1.3108238649
Registrant Email: res-dom@iana.org
Admin ID: IANA
Admin Name: Internet Assigned Numbers Authority
Admin Organization: Internet Assigned Numbers Authority (IANA)
Admin Street1: 4676 Admiralty Way
Admin Street2: Suite 330
Admin City: Marina del Rey
Admin State/Province: CA
Admin Postal Code: 92092
Admin Country: US
Admin Phone: +1.3108239358
Admin FAX: +1.3108238649
Admin Email: res-dom@iana.org
Tech ID: IANA
Tech Name: Internet Assigned Numbers Authority
Tech Organization: Internet Assigned Numbers Authority (IANA)
Tech Street1: 4676 Admiralty Way
Tech Street2: Suite 330
Tech City: Marina del Rey
Tech State/Province: CA
Tech Postal Code: 92092
Tech Country: US
Tech Phone: +1.3108239358
Tech FAX: +1.3108238649
Tech Email: res-dom@iana.org
Name Server: A.IANA-SERVERS.NET
Name Server: B.IANA-SERVERS.NET
EOF
    assert_equal exp, @org.to_s
  end
end
