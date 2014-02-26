class Whois::Domain::PublicInterest < Whois::Domain::Base
  HOST = "whois.pir.org"
  ATTR_MATCH = /^([^:]+):\s*(\S.*)\r$/
  responds_to :org

  ATTR_NAMES = {
    :registrar_name => "Sponsoring Registrar",
    :created_on => "Creation Date",
    :updated_on => "Updated Date",
    :expires_on => "Registry Expiry Date",
    :status => "Domain Status"
  }

  def available?
    @raw =~ /NOT FOUND/
  end
end