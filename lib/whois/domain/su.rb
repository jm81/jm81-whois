class Whois::Domain::Su < Whois::Domain::Base
  HOST = "whois.ripn.net"
  ATTR_MATCH = /\s*([^:]+):\s+(.*)$/
  responds_to :su

  ATTR_NAMES = {
    :registrar_name => "Registrar Name",
    :whois_server => "Registrar Whois",
    :created_on => "Domain Created",
    :updated_on => "Domain Last Updated",
    :expires_on => "Domain Currently Expires"
  }
  
  def available?
    @raw =~ /NOT FOUND/
  end
end