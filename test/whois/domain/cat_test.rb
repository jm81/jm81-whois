require 'test_helper'

class Whois::Domain::CatTest < Test::Unit::TestCase

  def test_whois  
    assert_whois_data(EXP_DATA)
    assert Whois::Domain.new("not-reg-1234.cat").available?
  end
  
  def test_register_url
    assert_equal "http://domini.cat/en_registrar.html", Whois::Domain.new("domini.cat").register_url
  end

  EXP_DATA = {
    :name => "domini.cat",
    :kind => "Cat",
    :created_on => "2006-05-05",
    :updated_on => "2009-06-19",
    :expires_on => "2010-05-05",
    :database_updated_at => false,
    :registrar_name => "R-906 (puntCAT Administrative Account)",
    :whois_server => "whois.cat",
    :raw_match => "Domain Name: domini.cat",
    :status => ['ok'],
    :name_servers => nil # I can't figure out a stable test. The order changes and they may have some weird space-like character at the end.
  }

end
