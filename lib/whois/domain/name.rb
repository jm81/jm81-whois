class Whois::Domain::Name < Whois::Domain::Base
  HOST = "whois.nic.name"
  ATTR_MATCH = /^([^:]+):\s(.*)\r$/
  responds_to :name

  ATTR_NAMES = {
    :registrar_name => "Sponsoring Registrar",
    :created_on => "Created On",
    :updated_on => "Updated On",
    :expires_on => "Expires On",
    :status => "Domain Status"
  }
  
  def available?
    @raw =~ /No match/
  end
  
  # whois.nic.name uses a query in the format
  # object = name. e.g. domain = john.smith.name
  def query_string
    "domain = #{@name}\n"
  end
end