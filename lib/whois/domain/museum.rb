class Whois::Domain::Museum < Whois::Domain::Base
  HOST = "whois.museum"
  ATTR_MATCH = /^([^:]+):\s(.*)\r$/
  responds_to :museum

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
    "http://about.museum/register/"
  end
end