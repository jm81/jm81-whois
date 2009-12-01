require 'test_helper'

class Whois::Domain::NeustarTest < Test::Unit::TestCase

  def test_biz
    assert_whois_data(EXP_BIZ.merge({:to_s => EXP_TO_S}))
    assert Whois::Domain.new("not-reg-1234.biz").available?
  end
  
  def test_us
    assert_whois_data(EXP_US)
    assert Whois::Domain.new("not-reg-1234.us").available?
  end

  def test_travel
    assert_whois_data(EXP_TRAVEL)
    assert Whois::Domain.new("not-reg-1234.travel").available?
  end

  EXP_BIZ = {
    :name => "neulevel.biz",
    :kind => "Neustar",
    :created_on => "2001-11-07",
    :updated_on => "2008-12-22",
    :expires_on => "2009-11-06",
    :registrar_name => "REGISTRY REGISTRAR",
    :whois_server => "whois.biz",
    :raw_match => "Domain Name:                                 NEULEVEL.BIZ",
    :status => ['clientDeleteProhibited', 'clientTransferProhibited', 'clientUpdateProhibited', 'serverDeleteProhibited', 'serverTransferProhibited', 'serverUpdateProhibited'],
    :name_servers => ['PDNS1.ULTRADNS.NET', 'PDNS2.ULTRADNS.NET', 'PDNS3.ULTRADNS.ORG', 'PDNS4.ULTRADNS.ORG', 'PDNS5.ULTRADNS.INFO', 'PDNS6.ULTRADNS.CO.UK']
  }
  
  EXP_US = {
    :name => "neustar.us",
    :kind => "Neustar",
    :created_on => "2002-04-18",
    :updated_on => "2009-06-02",
    :expires_on => "2010-04-17",
    :registrar_name => "REGISTRY REGISTRAR",
    :whois_server => "whois.nic.us",
    :raw_match => "Domain Name:                                 NEUSTAR.US",
    :status => ['clientDeleteProhibited', 'clientTransferProhibited', 'serverDeleteProhibited', 'serverTransferProhibited', 'serverUpdateProhibited'],
    :name_servers => ['GDNS1.ULTRADNS.NET', 'GDNS2.ULTRADNS.NET']
  }
  
  EXP_TRAVEL = {
    :name => "travel.travel",
    :kind => "Neustar",
    :created_on => "2005-10-04",
    :updated_on => "2006-07-23",
    :expires_on => "2010-10-03",
    :database_updated_at => true,
    :registrar_name => "NEUSTAR GATEWAY",
    :whois_server => "whois.nic.travel",
    :raw_match => "Domain Name:                                 TRAVEL.TRAVEL",
    :status => ['ok'],
    :name_servers => ['NETSYS.COM', 'NS01-MIA.THEGLOBE.COM']
  }
  
  EXP_TO_S = <<EOF
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
Registrant Email: support@NeuStar.biz
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
Administrative Contact Email: support@NeuStar.biz
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
Billing Contact Email: support@NeuStar.biz
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
Technical Contact Email: support@NeuStar.biz
Name Server: PDNS1.ULTRADNS.NET
Name Server: PDNS2.ULTRADNS.NET
Name Server: PDNS3.ULTRADNS.ORG
Name Server: PDNS4.ULTRADNS.ORG
Name Server: PDNS5.ULTRADNS.INFO
Name Server: PDNS6.ULTRADNS.CO.UK
Created by Registrar: REGISTRY REGISTRAR
Last Updated by Registrar: BATCHCSR
Domain Registration Date: Wed Nov 07 00:01:00 GMT 2001
Domain Expiration Date: Fri Nov 06 23:59:00 GMT 2009
Domain Last Updated Date: Mon Dec 22 01:40:11 GMT 2008
EOF
end
