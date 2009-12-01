require 'test_helper'

class Whois::Domain::MuseumTest < Test::Unit::TestCase

  def test_whois  
    assert_whois_data(EXP_DATA)
    assert Whois::Domain.new("not-reg-1234.museum").available?
  end
  
  def test_register_url
    assert_equal "http://about.museum/register/", Whois::Domain.new("nic.museum").register_url
  end

  EXP_DATA = {
    :name => "nic.museum",
    :kind => "Museum",
    :created_on => "2005-02-04",
    :updated_on => nil, # Doesn't have an updated at AFAIK
    :expires_on => "2015-02-04",
    :database_updated_at => false,
    :registrar_name => "CORE-904 (Musedoma)",
    :whois_server => "whois.museum",
    :raw_match => "Domain Name: nic.museum",
    :status => ['ok'],
    :name_servers => nil # Similar problem as Domain::Cat
  }

end
