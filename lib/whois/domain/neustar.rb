class Whois::Domain::Neustar < Whois::Domain::Base
  ATTR_MATCH = /^([^:]+):\s{2,}(.*)$/
  responds_to :biz, :us, :travel

  ATTR_NAMES = {
    :registrar_name => "Sponsoring Registrar",
    :created_on => "Domain Registration Date",
    :updated_on => "Domain Last Updated Date",
    :expires_on => "Domain Expiration Date",
    :status => "Domain Status"
  }

  def host
    case @name.match(/.*\.([^\.]+)$/)[1]
    when 'biz' then 'whois.biz'
    when 'us'  then 'whois.nic.us'
    when 'travel' then 'whois.nic.travel'
    end
  end

  def database_updated_at
    if(@raw =~ /Whois database was last updated on: ([^<]*)/)
      Time.parse($1)
    end
  end

  def whois_server
    host
  end
  
  def available?
    @raw =~ /Not found:/
  end
  
  def register_url
    if @name.match(/.*\.([^\.]+)$/)[1] == "travel"
      "http://www.travel.travel/authenticationframe.htm"
    else
      super
    end
  end
end