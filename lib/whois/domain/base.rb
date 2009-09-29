class Whois::Domain::Base
  attr_reader :name, :raw
  
  # Default keys for pairs in raw whois data.
  # :method_name => 'Default Key Text'
  ATTR_NAMES = {
    :registrar_name => "Registrar",
    :created_on => "Creation Date",
    :updated_on => "Updated Date",
    :expires_on => "Expiration Date",
    :status => "Status",
    :name_servers => "Name Server",
    :whois_server => "Whois Server"
  }
  
  # Inherited classes call class method +responds_to+ to say for which TLDs
  # that class is responsible.
  #
  # ==== Parameters
  # ary<Array of Symbol>:: splat of TLD's, as symbols
  def self.responds_to(*ary)
    Whois::Domain::tlds[self.name.split(":").last] = ary
  end
  
  # Initialize and run query for the given domain.
  #
  # ==== Parameters
  # name<String>:: The domain name (example.com)
  def initialize(name)
    @name = name
    query
  end
  
  # retun HOST constant for the running class
  def host
    self.class::HOST
  end
  
  # A merge of the ATTR_NAMES for the running class and the Base class. This
  # allows child classes to only define keys that are different from the 
  # default.
  def attr_names
    @attr_names ||= ATTR_NAMES.merge(self.class::ATTR_NAMES)
  end
  
  # Query the whois server and return all lines in +@raw+. Called by initialize.
  # Based on Michael Neumann's library.
  def query
    s = TCPsocket.open(host, 43)
    s.write("#{@name}\n")
    @raw = s.gets(nil)
    s.close
  end
  
  # Get Hash of attributes, by iterating through each line of +@raw+. If the
  # line matches the class's ATTR_MATCH constant, it is added to the +@attrs+
  # Hash. Each elements of +attrs+  is an Array, to allow for multiple lines
  # with a shared key (particular status and nameservers). Individual methods
  # use this Hash to return values. Parsing is only done once per object.
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
  
  # Return attributes as newline separated key value pairs ("key: value")
  def to_s
    s = ""
    raw.each do |i|
      if i =~ self.class::ATTR_MATCH
        s << "#{$1}: #{$2}\n"
      end
    end
    s
  end
  
  # Return the value of an attribute as a single String or nil. This returns 
  # only the first element of the attribute value (see +attr_array+). It is
  # preferred not to use this method directly.
  #
  # ==== Parameters
  # attr_name<Symbol>:: Matches the method name
  def attr_single(attr_name)
    attrs[attr_names[attr_name]] ? attrs[attr_names[attr_name]][0] : nil
  end
  
  # Return the whois_server used for getting details for this domain. For many
  # TLD's, all data is served from the primary whois server. A few TLD's have
  # details on separate servers. Return +host+ unless a whois_server is included
  # in the whois data.
  def whois_server
    attr_single(:whois_server) || host
  end
  
  %w{registrar_name}.each do |method_name|
    define_method method_name do
      attr_single(method_name.to_sym)
    end
  end
  
  # Return the value of an attribute converted to a Date object. This returns
  # only the first element of the attribute value. It is
  # preferred not to use this method directly.
  #
  # ==== Parameters
  # attr_name<Symbol>:: Matches the method name
  def attr_date(attr_name)
    attrs[attr_names[attr_name]] ? Date.parse(attrs[attr_names[attr_name]][0]) : nil
  end
  
  %w{created_on updated_on expires_on}.each do |method_name|
    define_method method_name do
      attr_date(method_name.to_sym)
    end
  end

  # Return all values of an attribute as an Array. It is
  # preferred not to use this method directly.
  #
  # ==== Parameters
  # attr_name<Symbol>:: Matches the method name
  def attr_array(attr_name)
    attrs[attr_names[attr_name]] || []
  end
  
  %w{status name_servers}.each do |method_name|
    define_method method_name do
      attr_array(method_name.to_sym)
    end
  end
  
  # Array of name servers
  def ns
    name_servers
  end
  
  # Is this domain expired (assuming it's registered)?
  def expired?
    expires_on && (expires_on < Date.today)
  end
  
  # Is this domain registered?
  def registered?
    !available?
  end
  
  # Some whois servers include the time of the last update to this domain in
  # the database. For those that do not, this returns nil.
  #
  # ==== Returns
  # Time:: Time of last database update, or nil.
  def database_updated_at
    nil
  end
  
  # A url for registering this domain.
  def register_url
    "https://www.securepaynet.net/gdshop/registrar/search.asp?prog_id=morgancr&domainToCheck=#{name}&checkAvail=1"
  end
end
