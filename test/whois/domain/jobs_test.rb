require 'test_helper'

class Whois::Domain::JobsTest < Test::Unit::TestCase
  def test_jobs
    assert_whois_data(EXP_JOBS)
    assert Whois::Domain.new("not-reg-1234.jobs").available?
  end

  def test_tv
    assert_whois_data(EXP_TV)
    assert Whois::Domain.new("not-reg-1234.tv").available?
  end

  EXP_JOBS = {
    :name => "goto.jobs",
    :kind => "VerisignGrs",
    :created_on => "2010-02-04",
    :updated_on => "2012-05-10",
    :expires_on => "2013-02-04",
    :registrar_name => "NAME SHARE, INC",
    :whois_server => "whois.nameshare.com",
    :raw_match => "Domain Name: GOTO.JOBS",
    :status => ['ACTIVE'],
    :name_servers => ['NS1.REGISTRY.JOBS', 'NS2.REGISTRY.JOBS']
  }

  EXP_TV = {
    :name => "www.tv",
    :kind => "VerisignGrs",
    :created_on => "2000-05-01",
    :updated_on => "2012-05-10",
    :expires_on => "2038-01-18",
    :registrar_name => "TUCOWS.COM CO.",
    :whois_server => "whois.tucows.com",
    :raw_match => "Domain name: WWW.TV",
    :status => ["CLIENT-UPDATE-PROHIBITED", "CLIENT-XFER-PROHIBITED"],
    :name_servers => ['A4.NSTLD.COM', 'F4.NSTLD.COM', 'G4.NSTLD.COM', 'H4.NSTLD.COM', 'J4.NSTLD.COM', 'K4.NSTLD.COM', 'L4.NSTLD.COM']
  }
end
