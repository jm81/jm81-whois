class Whois::Domain::Educause < Whois::Domain::Base
  HOST = "whois.educause.edu"
  ATTR_MATCH = /^([^:]+):\s+(.*)$/
  responds_to :edu

  ATTR_NAMES = {
    :created_on => "Domain record activated",
    :updated_on => "Domain record last updated",
    :expires_on => "Domain expires"
  }
  
  # Educause is the only registrar for .edu
  def registrar_name
    "Educause"
  end
  
  def available?
    @raw =~ /^No Match/
  end
  
  def name_servers
    found = false
    ns_ary = []
    @raw.each_line do |l|
      if l =~ /^Name Servers:/
        found = true
      elsif found && l =~ /^\s+(\S+)/
        ns_ary << $1
      elsif found && l.strip.empty?
        return ns_ary
      end
    end
    ns_ary
  end
  
  def ns
    name_servers
  end
  
  def register_url
    "http://www.educause.edu/edudomain"
  end
end