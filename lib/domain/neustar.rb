class Whois::Domain::Neustar < Whois::Domain::Base
  ATTR_MATCH = /^([^:]+):\s{2,}(.*)$/

  def host
    if @name.match(/.*\.([^\.]+)$/)[1].to_sym == :biz
      "whois.biz"
    else
      "whois.nic.us"
    end
  end

  def registrar_name
    attrs["Sponsoring Registrar"] ? attrs["Sponsoring Registrar"][0] : nil
  end
    
  def created_on
    attrs["Domain Registration Date"] ? Date.parse(attrs["Domain Registration Date"][0]) : nil
  end
  
  def updated_on
    attrs["Domain Last Updated Date"] ? Date.parse(attrs["Domain Last Updated Date"][0]) : nil
  end
  
  def expires_on
    attrs["Domain Expiration Date"] ? Date.parse(attrs["Domain Expiration Date"][0]) : nil
  end
  
  def database_updated_at
    if(@raw =~ /Whois database was last updated on: ([^<]*)/)
      Time.parse($1)
    end
  end
  
  def status
    attrs["Domain Status"]
  end
  
  # No whois server listed for .biz domains, so always return the whois server used here.
  def whois_server
    host
  end
end