require 'test/unit'
require 'whois'

class Test::Unit::TestCase

  # +exp+ expects a hash representing expected results (although +name+ also indicates
  # the domain to be queried if +d+ is not passed.) with the following keys:
  #  - name: domain name to be queried
  #  - kind: string identifying the name of the expected class
  #          (only the class name, namespace is assumed to be Whois::Domain)
  #  - created_on: Date created as string (YYYY-MM-DD)
  #  - updated_on: Date updated as string (YYYY-MM-DD)
  #  - expires_on: Expiration date as string (YYYY-MM-DD)
  #  - database_updated_at: false iff this server does not have such a value.
  #  - status: Array of statuses.
  #  - registrar_name: Name of Registrar
  #  - name_servers: Array of name servers
  #  - whois_server: Whois server domain
  #  - raw_match: A string to match against the raw data.
  #  - to_s: Expected to_s
  def assert_whois_data(exp, d = nil)
    d ||= Whois::Domain.new(exp[:name])

    assert_kind_of Whois::Domain.const_get(exp[:kind]), d, "#{exp[:name]} should be an instance of Whois::Domain::#{exp[:kind]}"
    assert_equal exp[:name], d.name, "Verify that name returns same as name given"

    assert_equal(Date.parse(exp[:expires_on]).to_s, d.expires_on.to_s, "expiration date") unless exp[:expires_on].nil?
    assert_equal(Date.parse(exp[:created_on]).to_s, d.created_on.to_s, "creation date") unless exp[:created_on].nil?
    assert_equal(Date.parse(exp[:updated_on]).to_s, d.updated_on.to_s, "updated date") unless exp[:updated_on].nil?

    if exp[:database_updated_at] == false
      assert_nil d.database_updated_at, "no database_updated_at expected on this server"
    else
      assert_kind_of Time, d.database_updated_at, "database_updated_at should return a time object"
    end

    assert_kind_of Array, d.status, "status should return an Array"
    assert_equal exp[:status], d.status

    assert_kind_of Array, d.name_servers, "name_server should return an Array"
    unless exp[:name_servers].nil? # see CatTest
      assert_equal exp[:name_servers], d.name_servers
      assert_equal d.name_servers, d.ns, "ns is an alias for name_servers"
    end

    assert_equal exp[:registrar_name], d.registrar_name
    assert_equal exp[:whois_server], d.whois_server

    assert_kind_of String, d.raw
    assert_match exp[:raw_match], d.raw

    if exp[:to_s]
      assert_equal exp[:to_s], d.to_s
    end

    assert !d.available?
    assert d.registered?
  end
end