class Whois::Domain::Aero < Whois::Domain::Base
  HOST = "whois.aero"
  ATTR_MATCH = /^([^:]+):(\S.*)\r$/
  responds_to :aero

  ATTR_NAMES = {
    :registrar_name => "Sponsoring Registrar",
    :created_on => "Created On",
    :updated_on => "Updated On",
    :expires_on => "Expires On",
    :status => "Domain Status"
  }
  
  def available?
    @raw =~ /NOT FOUND/
  end
end