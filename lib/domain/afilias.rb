class Whois::Domain::Afilias < Whois::Domain::Base
  HOST = "whois.afilias.net"
  ATTR_MATCH = /^([^:]+):(\S.*)\r$/

  ATTR_NAMES = {
    :registrar_name => "Sponsoring Registrar",
    :created_on => "Created On",
    :updated_on => "Last Updated On",
    :expires_on => "Expiration Date"
  }
  
  # I couldn't find any database updated information for .org
  def database_updated_at
    nil
  end
  
  # No whois server listed for .org domains, so always return the whois server used here.
  def whois_server
    HOST
  end
  
  def available?
    @raw =~ /NOT FOUND/
  end
end