class Whois::Domain::PublicInterest < Whois::Domain::Base
  HOST = "whois.pir.org"
  ATTR_MATCH = /^([^:]+):(\S.*)\r$/
  responds_to :org

  ATTR_NAMES = {
    :registrar_name => "Sponsoring Registrar",
    :created_on => "Created On",
    :updated_on => "Last Updated On"
  }
  
  def whois_server
    HOST
  end
  
  def available?
    @raw =~ /NOT FOUND/
  end
end