class Whois::Domain::Int < Whois::Domain::Base
  HOST = "whois.iana.org"
  ATTR_MATCH = /^([^:]+):\s+(\S.*)$/
  responds_to :int

  ATTR_NAMES = {
    :created_on => 'created',
    :updated_on => 'changed',
    :name_servers => 'nserver'
  }

  def registrar_name
    ".int Domain Registry (IANA)"
  end

  def available?
     @raw =~ /returned 0 objects/
  end

  def name_servers
    # Remove IP address.
    super.collect{ |ns| ns.match(/\A([\S]*)\s/)[1] }
  end
end