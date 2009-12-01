class Whois::Domain::Ws < Whois::Domain::Base
  HOST = "whois.website.ws"
  ATTR_MATCH = /\s*([^:]+):\s+(.*)$/
  responds_to :ws

  ATTR_NAMES = {
    :registrar_name => "Registrar Name",
    :whois_server => "Registrar Whois",
    :created_on => "Domain Created",
    :updated_on => "Domain Last Updated",
    :expires_on => "Domain Currently Expires"
  }
  
  def available?
    @raw =~ /^No match/
  end
  
  def name_servers
    found = false
    ns_ary = []
    @raw.each_line do |l|
      if l =~ /Current Nameservers:/
        found = true
      elsif found && l =~ /^\s*(\S+)/
        ns_ary << $1
      end
    end
    ns_ary
  end
end
