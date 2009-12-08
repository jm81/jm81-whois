class Whois::Domain::VerisignGrs < Whois::Domain::Base
  HOST = "whois.verisign-grs.com"
  ATTR_MATCH = /^   ([^:]+):\W*(.*)$/
  responds_to :com, :net, :jobs, :tv
  
  def initialize(name)
    @name = name
    @host = nil

    query

    unless ( whois_server.empty? || whois_server == HOST )
      @host = whois_server
      query
    end
  end
  
  def host
    return @host unless @host.nil?

    case @name.match(/.*\.([^\.]+)$/)[1]
      when 'jobs' then "jobswhois.verisign-grs.com"
      when 'tv'   then "tvwhois.verisign-grs.com"
      else             "whois.verisign-grs.com"
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

  def registrant_id
    found = false
    @raw.each_line do |l|
      if l =~ /^Organisation Contact/
        found = true
      elsif found && l =~ /^ID\.+:\s+(.+)/
        return $1
      end
    end
    ''
  end
end
