module Whois::Domain
  TLD = {
    "VerisignGrs" => [:com, :net]
  }

  def self.new(domain_name)
    tld = domain_name.match(/.*\.([^\.]+)$/)[1].to_sym
    class_name = TLD.find{|c, tlds| tlds.include?(tld)}[0]
    const_get(class_name).new(domain_name)
  end
end

class Whois::Domain::Base
  attr_reader :name, :raw
  
  def initialize(name)
    @name = name
    query
  end
  
  # based on Michael Neumann's library
  def query
    s = TCPsocket.open(self.class::HOST, 43)
    s.write("#{@name}\n")
    ret = ""
    while s.gets do ret += $_ end
    s.close
    @raw = ret
  end
    
  def registrar_name
    attrs["Registrar"] ? attrs["Registrar"][0] : nil
  end
    
  def created_on
    attrs["Creation Date"] ? Date.parse(attrs["Creation Date"][0]) : nil
  end
  
  def updated_on
    attrs["Updated Date"] ? Date.parse(attrs["Updated Date"][0]) : nil
  end
  
  def expires_on
    attrs["Expiration Date"] ? Date.parse(attrs["Expiration Date"][0]) : nil
  end
  
  def status
    attrs["Status"]
  end
  
  def name_servers
    attrs["Name Server"]
  end
  
  alias :ns :name_servers
  
  def whois_server
    attrs["Whois Server"] ? attrs["Whois Server"][0] : nil
  end
end

Dir["#{File.dirname(__FILE__)}/domain/*.rb"].sort.each { |ext| require ext }