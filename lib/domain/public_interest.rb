class Whois::Domain::PublicInterest < Whois::Domain::Base
  HOST = "whois.pir.org"
  ATTR_MATCH = /^([^:]+):(\S.*)\r$/
  
  def registrar_name
    attrs["Sponsoring Registrar"] ? attrs["Sponsoring Registrar"][0] : nil
  end
    
  def created_on
    attrs["Created On"] ? Date.parse(attrs["Created On"][0]) : nil
  end
  
  def updated_on
    attrs["Last Updated On"] ? Date.parse(attrs["Last Updated On"][0]) : nil
  end
  
  # I couldn't find any database updated information for .org
  def database_updated_at
    nil
  end
  
  # No whois server listed for .org domains, so always return the whois server used here.
  def whois_server
    HOST
  end
end