require 'test_helper'

class Whois::Domain::EducauseTest < Test::Unit::TestCase

  def test_whois  
    assert_whois_data(EXP_DATA)
    assert Whois::Domain.new('not-reg-1234.edu').available?
  end

  EXP_DATA = {
    :name => 'educause.edu',
    :kind => 'Educause',
    :created_on => '1998-03-11',
    :updated_on => '2011-03-22',
    :expires_on => '2011-07-31',
    :database_updated_at => false,
    :registrar_name => 'Educause',
    :whois_server => 'whois.educause.edu',
    :raw_match => 'Domain Name: EDUCAUSE.EDU',
    :status => [],
    :name_servers => ['NS3.EDUCAUSE.EDU','NS01.ENG01.DATA393.NET', 'NS5.EDUCAUSE.EDU', 'NS02.ENG01.DATA393.NET']
  }

end
