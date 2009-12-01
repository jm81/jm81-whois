class Whois::Domain::Int < Whois::Domain::Base
  HOST = "whois.iana.org"
  ATTR_MATCH = /^\s{0,4}([^:]+):\s+(\S.*)\r$/
  responds_to :int

  ATTR_NAMES = {
    :registrar_name => "Sponsoring Registrar",
    :created_on => "Registration Date",
    :updated_on => "Last Updated Date",
    :name_servers => "Nameserver"
  }
  
  def registrar_name
    ".int Domain Registry (IANA)"
  end
  
  def available?
    @raw =~ /not found/
  end
  
  def created_on
    Date.parse(attrs["Registration Date"][-1])
  end

  def updated_on
    Date.parse(attrs["Last Updated Date"][-1])
  end
  
  def name_servers
    # Remove trailing dot.
    super.collect{ |ns| ns[0..-2] }
  end
end