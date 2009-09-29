class Whois::Domain::Afilias < Whois::Domain::Base
  HOST = "whois.afilias.net"
  ATTR_MATCH = /^([^:]+):(\S.*)\r$/
  responds_to :info

  ATTR_NAMES = {
    :registrar_name => "Sponsoring Registrar",
    :created_on => "Created On",
    :updated_on => "Last Updated On",
    :expires_on => "Expiration Date"
  }
  
  def whois_server
    HOST
  end
  
  def available?
    @raw =~ /NOT FOUND/
  end
end