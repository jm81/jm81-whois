class Whois::Domain::Neustar < Whois::Domain::Base
  ATTR_MATCH = /^([^:]+):\s{2,}(.*)$/

  ATTR_NAMES = {
    :registrar_name => "Sponsoring Registrar",
    :created_on => "Domain Registration Date",
    :updated_on => "Domain Last Updated Date",
    :expires_on => "Domain Expiration Date",
    :status => "Domain Status"
  }

  def host
    if @name.match(/.*\.([^\.]+)$/)[1].to_sym == :biz
      "whois.biz"
    else
      "whois.nic.us"
    end
  end

  def database_updated_at
    if(@raw =~ /Whois database was last updated on: ([^<]*)/)
      Time.parse($1)
    end
  end

  # No whois server listed for .biz domains, so always return the whois server used here.
  def whois_server
    host
  end
end