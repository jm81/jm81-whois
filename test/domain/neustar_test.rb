require 'test/unit'
require File.join(File.dirname(__FILE__), "..", "..", "lib", "whois")

class NeustarTest < Test::Unit::TestCase
  BIZ = Whois::Domain.new("neulevel.biz")
  
  def setup
    @biz = BIZ
  end

  def test_initialize
    assert_kind_of Whois::Domain::Neustar, @biz
  end
  
  def test_name
    assert_equal "neulevel.biz", @biz.name
  end
  
  def test_dates
    assert_equal Date.parse("2007-11-06").to_s, @biz.expires_on.to_s, "expiration date"
    assert_equal Date.parse("2001-11-07").to_s, @biz.created_on.to_s, "creation date"
    assert_equal Date.parse("2006-12-22").to_s, @biz.updated_on.to_s, "updated date"
    assert_kind_of Time, @biz.database_updated_at
  end
  
  def test_status
    assert_kind_of Array, @biz.status
    assert_equal ['clientDeleteProhibited', 'clientTransferProhibited', 'clientUpdateProhibited', 'serverDeleteProhibited', 'serverTransferProhibited', 'serverUpdateProhibited'], @biz.status
  end
  
  def test_name_servers
    assert_kind_of Array, @biz.name_servers
    assert_equal ['PDNS1.ULTRADNS.NET', 'PDNS2.ULTRADNS.NET', 'PDNS3.ULTRADNS.ORG', 'PDNS4.ULTRADNS.ORG', 'PDNS5.ULTRADNS.INFO', 'PDNS6.ULTRADNS.CO.UK'], @biz.name_servers
    assert_equal @biz.name_servers, @biz.ns, "ns is an alias for name_servers"
  end
  
  def test_registrar_name
    assert_equal "REGISTRY REGISTRAR", @biz.registrar_name
  end
  
  def test_whois_server
    assert_equal "whois.biz", @biz.whois_server
  end
  
  def test_raw
    assert_kind_of String, @biz.raw
    assert_match "Domain Name:                                 NEULEVEL.BIZ", @biz.raw
  end
  
  def test_to_s
    exp = <<EOF
Domain Name: NEULEVEL.BIZ
Domain ID: D592-BIZ
Sponsoring Registrar: REGISTRY REGISTRAR
Domain Status: clientDeleteProhibited
Domain Status: clientTransferProhibited
Domain Status: clientUpdateProhibited
Domain Status: serverDeleteProhibited
Domain Status: serverTransferProhibited
Domain Status: serverUpdateProhibited
Registrant ID: NEULEVEL1
Registrant Name: NeuStar, Inc.
Registrant Organization: NeuStar, Inc.
Registrant Address1: Loudoun Tech Center
Registrant Address2: 45980 Center Oak Plaza
Registrant City: Sterling
Registrant State/Province: Virginia
Registrant Postal Code: 20166
Registrant Country: United States
Registrant Country Code: US
Registrant Phone Number: +1.5714345757
Registrant Facsimile Number: +1.5714345758
Registrant Email: support@neulevel.biz
Administrative Contact ID: NEULEVEL1
Administrative Contact Name: NeuStar, Inc.
Administrative Contact Organization: NeuStar, Inc.
Administrative Contact Address1: Loudoun Tech Center
Administrative Contact Address2: 45980 Center Oak Plaza
Administrative Contact City: Sterling
Administrative Contact State/Province: Virginia
Administrative Contact Postal Code: 20166
Administrative Contact Country: United States
Administrative Contact Country Code: US
Administrative Contact Phone Number: +1.5714345757
Administrative Contact Facsimile Number: +1.5714345758
Administrative Contact Email: support@neulevel.biz
Billing Contact ID: NEULEVEL1
Billing Contact Name: NeuStar, Inc.
Billing Contact Organization: NeuStar, Inc.
Billing Contact Address1: Loudoun Tech Center
Billing Contact Address2: 45980 Center Oak Plaza
Billing Contact City: Sterling
Billing Contact State/Province: Virginia
Billing Contact Postal Code: 20166
Billing Contact Country: United States
Billing Contact Country Code: US
Billing Contact Phone Number: +1.5714345757
Billing Contact Facsimile Number: +1.5714345758
Billing Contact Email: support@neulevel.biz
Technical Contact ID: NEULEVEL1
Technical Contact Name: NeuStar, Inc.
Technical Contact Organization: NeuStar, Inc.
Technical Contact Address1: Loudoun Tech Center
Technical Contact Address2: 45980 Center Oak Plaza
Technical Contact City: Sterling
Technical Contact State/Province: Virginia
Technical Contact Postal Code: 20166
Technical Contact Country: United States
Technical Contact Country Code: US
Technical Contact Phone Number: +1.5714345757
Technical Contact Facsimile Number: +1.5714345758
Technical Contact Email: support@neulevel.biz
Name Server: PDNS1.ULTRADNS.NET
Name Server: PDNS2.ULTRADNS.NET
Name Server: PDNS3.ULTRADNS.ORG
Name Server: PDNS4.ULTRADNS.ORG
Name Server: PDNS5.ULTRADNS.INFO
Name Server: PDNS6.ULTRADNS.CO.UK
Created by Registrar: REGISTRY REGISTRAR
Last Updated by Registrar: BATCHCSR
Domain Registration Date: Wed Nov 07 00:01:00 GMT 2001
Domain Expiration Date: Tue Nov 06 23:59:00 GMT 2007
Domain Last Updated Date: Fri Dec 22 01:40:06 GMT 2006
EOF
    assert_equal exp, @biz.to_s
  end
end
