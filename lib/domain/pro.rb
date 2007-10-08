class Whois::Domain::Pro < Whois::Domain::Base
  HOST = "whois.registrypro.pro"
  ATTR_MATCH = /^  ([^:]+):\W*(.*)$/
  responds_to :pro
  
  ATTR_NAMES = {
    :registrar_name => "Registrar",
    :created_on => "Creation date",
    :updated_on => "Last updated",
    :expires_on => "Expiration date",
    :status => "Domain statuses"
  }
  
  def database_updated_at
    nil
  end
  
  def status
    attrs["Domain statuses"] ? attrs["Domain statuses"][0].split(",").collect{|d| d.strip} : nil
  end
  
  def name_servers
    found = false
    ns_ary = []
    @raw.each_line do |l|
      if l =~ /Domain servers in listed order:/
        found = true
      elsif found && !l.strip.empty?
        ns_ary << l.strip
      end
    end
    ns_ary
  end

  def ns
    name_servers
  end

  def whois_server
    HOST
  end
  
  def register_url
    "http://www.registrypro.pro/partners_findaregistrar.htm"
  end

  def available?
    @raw =~ /^Unknown domain/
  end
end