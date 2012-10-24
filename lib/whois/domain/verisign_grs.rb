class Whois::Domain::VerisignGrs < Whois::Domain::Base
  HOST = "whois.verisign-grs.com"
  ATTR_MATCH = /^   ([^:]+):\W*(.*)$/
  responds_to :com, :net

  def initialize(name)
    @name = name
    @host = nil

    query

    # Requery if the whois_server is different from HOST (or whois.iana.org
    # which doesn't appear to return much data). Check that the whois_server
    # does in fact return data before using.
    unless ( whois_server.empty? || [HOST, 'whois.iana.org'].include?(whois_server) )
      @host = whois_server
      old_raw = @raw
      query
      @raw = old_raw if (@raw =~ /not available/)
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

  def query_string
    if host == "whois.verisign-grs.com"
      "domain #{@name.upcase}\n"
    else
      "#{@name.upcase}\n"
    end
  end

  DATABASE_UPDATED_AT_REGEXES = [
    /Last update of whois database: ([^<]*)/,
    /Record last updated on ([^\.]*)/
  ]

  def database_updated_at
    DATABASE_UPDATED_AT_REGEXES.each do |regex|
      if (match_data = @raw.match(regex))
        return Time.parse(match_data[1])
      end
    end

    return nil
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
