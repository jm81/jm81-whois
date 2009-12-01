class Whois::Domain::Mobi < Whois::Domain::Base
  HOST = "whois.dotmobiregistry.net"
  ATTR_MATCH = /^([^:]+):(\S.*)\r$/
  responds_to :mobi

  ATTR_NAMES = {
    :registrar_name => "Sponsoring Registrar",
    :created_on => "Created On",
    :updated_on => "Last Updated On",
    :expires_on => "Expiration Date"
  }
  
  def available?
    @raw =~ /NOT FOUND/
  end
end