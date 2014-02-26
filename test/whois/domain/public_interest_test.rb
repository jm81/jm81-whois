require 'test_helper'

class Whois::Domain::PublicInterestTest < Test::Unit::TestCase

  def test_whois
    assert_whois_data(EXP_DATA.merge({:to_s => EXP_TO_S}))
    assert Whois::Domain.new("not-reg-1234.org").available?
  end

  EXP_DATA = {
    :name => "example.org",
    :kind => "PublicInterest",
    :created_on => '1995-08-31',
    :updated_on => '2010-07-27',
    :expires_on => '2010-08-30',
    :database_updated_at => false,
    :registrar_name => "Internet Assigned Numbers Authority (IANA) (R193-LROR)",
    :whois_server => "whois.pir.org",
    :raw_match => "Domain Name:EXAMPLE.ORG",
    :status => ['serverDeleteProhibited', 'serverRenewProhibited', 'serverTransferProhibited', 'serverUpdateProhibited'],
    :name_servers => ['A.IANA-SERVERS.NET', 'B.IANA-SERVERS.NET']
  }

  EXP_TO_S = <<EOF
Domain Name: EXAMPLE.ORG
Domain ID: D2328855-LROR
Creation Date: 1995-08-31T04:00:00Z
Updated Date: 2010-07-27T20:57:51Z
Registry Expiry Date: 2010-08-30T04:00:00Z
Sponsoring Registrar: Internet Assigned Numbers Authority (IANA) (R193-LROR)
Sponsoring Registrar IANA ID: 376
Domain Status: serverDeleteProhibited
Domain Status: serverRenewProhibited
Domain Status: serverTransferProhibited
Domain Status: serverUpdateProhibited
Registrant ID: IANA
Registrant Name: Internet Assigned Numbers Authority
Registrant Organization: Internet Assigned Numbers Authority (IANA)
Registrant Street: 4676 Admiralty Way
Registrant City: Marina del Rey
Registrant State/Province: CA
Registrant Postal Code: 92092
Registrant Country: US
Registrant Phone: +1.3108239358
Registrant Fax: +1.3108238649
Registrant Email: res-dom@iana.org
Admin ID: IANA
Admin Name: Internet Assigned Numbers Authority
Admin Organization: Internet Assigned Numbers Authority (IANA)
Admin Street: 4676 Admiralty Way
Admin City: Marina del Rey
Admin State/Province: CA
Admin Postal Code: 92092
Admin Country: US
Admin Phone: +1.3108239358
Admin Fax: +1.3108238649
Admin Email: res-dom@iana.org
Tech ID: IANA
Tech Name: Internet Assigned Numbers Authority
Tech Organization: Internet Assigned Numbers Authority (IANA)
Tech Street: 4676 Admiralty Way
Tech City: Marina del Rey
Tech State/Province: CA
Tech Postal Code: 92092
Tech Country: US
Tech Phone: +1.3108239358
Tech Fax: +1.3108238649
Tech Email: res-dom@iana.org
Name Server: A.IANA-SERVERS.NET
Name Server: B.IANA-SERVERS.NET
DNSSEC: signedDelegation
DS Created 1: 2010-07-27T20:57:22Z
DS Key Tag 1: 31589
Algorithm 1: 8
Digest Type 1: 1
Digest 1: 7b8370002875dda781390a8e586c31493847d9bc
DS Maximum Signature Life 1: 1814400 seconds
DS Created 2: 2010-07-27T20:57:36Z
DS Key Tag 2: 31589
Algorithm 2: 8
Digest Type 2: 2
Digest 2: 3fdc4c11fa3ad3535ea8c1ce3eaf7bfa5ca9ae8a834d98fee10085cfaeb625aa
DS Maximum Signature Life 2: 1814400 seconds
EOF

end
