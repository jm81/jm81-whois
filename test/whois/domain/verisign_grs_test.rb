require 'test_helper'

class Whois::Domain::VerisignGrsTest < Test::Unit::TestCase
  def test_com
    assert_whois_data(EXP_COM.merge({:to_s => EXP_COM_TO_S}))
    assert Whois::Domain.new("not-reg-1234.com").available?
  end

  def test_net
    assert_whois_data(EXP_NET)
    assert Whois::Domain.new("not-reg-1234.net").available?
  end

  def test_jobs
    assert_whois_data(EXP_JOBS)
    assert Whois::Domain.new("not-reg-1234.jobs").available?
  end

  def test_tv
    assert_whois_data(EXP_TV)
    assert Whois::Domain.new("not-reg-1234.tv").available?
  end

  EXP_COM = {
    :name => "example.com",
    :kind => "VerisignGrs",
    :created_on => "1995-08-14",
    :updated_on => "2011-08-14",
    :expires_on => "2012-08-13",
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
    :updated_on => "2011-08-31",
    :expires_on => "2012-08-30",
    :registrar_name => "RESERVED-INTERNET ASSIGNED NUMBERS AUTHORITY",
    :whois_server => "whois.iana.org",
    :raw_match => "Domain Name: EXAMPLE.NET",
    :status => ['clientDeleteProhibited', 'clientTransferProhibited', 'clientUpdateProhibited'],
    :name_servers => ['A.IANA-SERVERS.NET', 'B.IANA-SERVERS.NET']
  }

  EXP_JOBS = {
    :name => "goto.jobs",
    :kind => "VerisignGrs",
    :created_on => "2010-02-04",
    :updated_on => "2012-02-05",
    :expires_on => "2013-02-04",
    :registrar_name => "NAME SHARE, INC",
    :whois_server => "whois.nameshare.com",
    :raw_match => "Domain Name: GOTO.JOBS",
    :status => ['ACTIVE'],
    :name_servers => ['NS2.REGISTRY.JOBS', 'NS1.REGISTRY.JOBS']
  }

  EXP_TV = {
    :name => "www.tv",
    :kind => "VerisignGrs",
    :created_on => "2000-05-01",
    :updated_on => "2012-02-21",
    :expires_on => "2038-01-18",
    :registrar_name => "TUCOWS.COM CO.",
    :whois_server => "whois.tucows.com",
    :raw_match => "Domain name: WWW.TV",
    :status => ["CLIENT-XFER-PROHIBITED", "CLIENT-UPDATE-PROHIBITED"],
    :name_servers => ['A4.NSTLD.COM', 'F4.NSTLD.COM', 'G4.NSTLD.COM', 'H4.NSTLD.COM', 'J4.NSTLD.COM', 'L4.NSTLD.COM', 'K4.NSTLD.COM']
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
Updated Date: 14-aug-2011
Creation Date: 14-aug-1995
Expiration Date: 13-aug-2012
EOF
end
