class Whois::Domain::VerisignGrs < Whois::Domain::Base
  HOST = "whois.verisign-grs.com"
  ATTR_MATCH = /^   ([^:]+):\W*(.*)$/
  responds_to :com, :net, :jobs, :tv
  
  def host
    case @name.match(/.*\.([^\.]+)$/)[1]
    when 'jobs' then "jobswhois.verisign-grs.com"
    when 'tv'   then "tvwhois.verisign-grs.com"  
    else             "whois.verisign-grs.com"
    end
  end
  
  # For best results, this use object = name format.
  # e.g. domain = john.smith.name
  def query_string
    "domain = #{@name}\n"
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