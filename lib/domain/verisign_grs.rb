class Whois::Domain::VerisignGrs < Whois::Domain::Base
  HOST = "whois.verisign-grs.com"
  ATTR_MATCH = /^   ([^:]+):\W*(.*)$/
  responds_to :com, :net, :jobs
  
  def host
    if @name.match(/.*\.([^\.]+)$/)[1].to_sym == :jobs
      "jobswhois.verisign-grs.com"
    else
      "whois.verisign-grs.com"
    end
  end
  
  def database_updated_at
    if(@raw =~ /Last update of whois database: ([^<]*)/)
      Time.parse($1)
    end
  end
  
  def available?
    @raw =~ /^No match for/
  end
end