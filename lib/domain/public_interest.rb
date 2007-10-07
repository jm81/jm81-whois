class Whois::Domain::PublicInterest < Whois::Domain::Base
  HOST = "whois.pir.org"
  ATTR_MATCH = /^([^:]+):(\S.*)\r$/

  ATTR_NAMES = {
    :registrar_name => "Sponsoring Registrar",
    :created_on => "Created On",
    :updated_on => "Last Updated On"
  }
  
  # I couldn't find any database updated information for .org
  def database_updated_at
    nil
  end
  
  # No whois server listed for .org domains, so always return the whois server used here.
  def whois_server
    HOST
  end
end