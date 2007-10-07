require 'test/unit'
require File.join(File.dirname(__FILE__), "..", "lib", "whois")

# Test Whois::Domain methods that are generic to all servers
class WhoisDomainTest < Test::Unit::TestCase

  def test_expired
    assert !Whois::Domain.new("example.com").expired?
    assert !Whois::Domain.new("example.org").expired?
  end
end
