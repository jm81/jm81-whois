class Whois::Domain::Cat < Whois::Domain::Base
  HOST = "whois.cat"
  ATTR_MATCH = /^([^:]+):\s(.*)\r$/
  responds_to :cat

  ATTR_NAMES = {
    :registrar_name => "Registrar ID",
    :created_on => "Created On",
    :updated_on => "Last Updated On",
    :expires_on => "Expiration Date"
  }
  
  def available?
    @raw =~ /NOT FOUND/
  end
  
  def register_url
    "http://domini.cat/en_registrar.html"
  end
end