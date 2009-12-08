class Whois::Domain::Cz < Whois::Domain::Base
  HOST = "whois.nic.cz"
  ATTR_MATCH = /^([^:]+):\s+(\S.*)\r$/
  responds_to :cz

  ATTR_NAMES = {
    :registrar_name => "registrar",
    :created_on => "registered",
    :updated_on => "changed",
    :name_servers => "nserver",
    :expires_on => "expire",
    :status => "status",
    :registrant_id => "contact"
  }

  def query_string
    "#{@name}\r\n"
  end

  def available?
    @raw =~ /No entries found/
  end

  def name_servers
    attr_array(:name_servers).map {|ns| ns.gsub(/\s+.*$/, "") }
  end

  def register_url
    "http://www.nic.cz/page/313/"
  end
end
