require 'test/unit'
require File.join(File.dirname(__FILE__), "..", "lib", "whois")

# Test Whois::Domain methods that are generic to all servers
class Whois::Domain::BaseTest < Test::Unit::TestCase

  def test_expired
    assert !Whois::Domain.new("example.com").expired?
    assert !Whois::Domain.new("example.org").expired?
  end
  
  def test_register_url
    assert_equal "https://www.securepaynet.net/gdshop/registrar/search.asp?prog_id=morgancr&domainToCheck=example.com&checkAvail=1", Whois::Domain.new("example.com").register_url
    assert_equal "https://www.securepaynet.net/gdshop/registrar/search.asp?prog_id=morgancr&domainToCheck=example.org&checkAvail=1", Whois::Domain.new("example.org").register_url
  end
end
