class Whois::Domain::Base
  attr_reader :name, :raw
  
  ATTR_NAMES = {
    :registrar_name => "Registrar",
    :created_on => "Creation Date",
    :updated_on => "Updated Date",
    :expires_on => "Expiration Date",
    :status => "Status",
    :name_servers => "Name Server",
    :whois_server => "Whois Server"
  }
  
  def self.responds_to(*ary)
    Whois::Domain::tlds[self.name.split(":").last] = ary
  end
  
  def initialize(name)
    @name = name
    query
  end
  
  def host
    self.class::HOST
  end
  
  def attr_names
    @attr_names ||= ATTR_NAMES.merge(self.class::ATTR_NAMES)
  end
  
  # based on Michael Neumann's library
  def query
    s = TCPsocket.open(host, 43)
    s.write("#{@name}\n")
    ret = ""
    while s.gets do ret += $_ end
    s.close
    @raw = ret
  end
  
  # based on Michael Neumann's library
  def attrs
    return @attrs if @attrs
    
    actual_object = {}
    raw.each do |i|
      if i =~ self.class::ATTR_MATCH
        if actual_object.has_key? $1 then
          actual_object[$1] << $2
        else
          actual_object[$1] = [$2]
        end
      end
    end
    @attrs = actual_object
  end
  
  def to_s
    s = ""
    raw.each do |i|
      if i =~ self.class::ATTR_MATCH
        s << "#{$1}: #{$2}\n"
      end
    end
    s
  end
  
  def attr_single(attr_name)
    attrs[attr_names[attr_name]] ? attrs[attr_names[attr_name]][0] : nil
  end
  
  %w{registrar_name whois_server}.each do |method_name|
    define_method method_name do
      attr_single(method_name.to_sym)
    end
  end
  
  def attr_date(attr_name)
    attrs[attr_names[attr_name]] ? Date.parse(attrs[attr_names[attr_name]][0]) : nil
  end
  
  %w{created_on updated_on expires_on}.each do |method_name|
    define_method method_name do
      attr_date(method_name.to_sym)
    end
  end

  def attr_array(attr_name)
    attrs[attr_names[attr_name]] || []
  end
  
  %w{status name_servers}.each do |method_name|
    define_method method_name do
      attr_array(method_name.to_sym)
    end
  end
  
  alias :ns :name_servers
  
  def expired?
    expires_on && (expires_on < Date.today)
  end
  
  def registered?
    !available?
  end
  
  # A url for registering this domain.
  def register_url
    "https://www.securepaynet.net/gdshop/registrar/search.asp?prog_id=morgancr&domainToCheck=#{name}&checkAvail=1"
  end
end
