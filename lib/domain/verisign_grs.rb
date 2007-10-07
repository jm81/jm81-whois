class Whois::Domain::VerisignGrs < Whois::Domain::Base
  HOST = "whois.verisign-grs.com"
  ATTR_MATCH = /^   ([^:]+):\W*(.*)$/
  
  def database_updated_at
    if(@raw =~ /Last update of whois database: ([^<]*)/)
      Time.parse($1)
    end
  end
  
  def available?
    @raw =~ /^No match for/
  end
end