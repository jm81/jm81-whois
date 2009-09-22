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
  
  def database_updated_at
    nil
  end
  
  def whois_server
    HOST
  end
  
  def available?
    @raw =~ /No match/
  end
  
  # whois.nic.name uses a query in the format
  # object = name. e.g. domain = john.smith.name
  def query
    s = TCPsocket.open(host, 43)
    s.write("domain = #{@name}\n")
    ret = ""
    while s.gets do ret += $_ end
    s.close
    @raw = ret
  end
end