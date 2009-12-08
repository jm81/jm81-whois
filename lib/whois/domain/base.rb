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
    :whois_server => "Whois Server",
    :registrant_id => "Registrant",
    :administrative_id => "Administrative"
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
  
  # The string to use in +query+. This is generally just the domain name
  # followed by a new line, but some servers have a different format.
  def query_string
    "#{@name}\n"
  end
  
  # Query the whois server and return all lines in +@raw+. Called by initialize.
  # Based on Michael Neumann's library.
  def query
    s = TCPsocket.open(host, 43)
    s.write(query_string)
    @raw = s.gets(nil)
    s.close
  end
  
  private :attr_names, :query_string, :query
  
  # Get Hash of attributes, by iterating through each line of +@raw+. If the
  # line matches the class's ATTR_MATCH constant, it is added to the +@attrs+
  # Hash. Each elements of +attrs+  is an Array, to allow for multiple lines
  # with a shared key (particular status and nameservers). Individual methods
  # use this Hash to return values. Parsing is only done once per object.
  # based on Michael Neumann's library
  def attrs
    return @attrs if @attrs
    
    @attrs = Hash.new { |hsh, key| hsh[key] = [] }
    raw.each do |line|
      m = self.class::ATTR_MATCH.match(line)
      @attrs[m[1]] << m[2] if m
    end
    return @attrs
  end
  
  # Return attributes as newline separated key value pairs ("key: value")
  def to_s
    s = ""
    raw.each do |line|
      m = self.class::ATTR_MATCH.match(line)
      s << "#{m[1]}: #{m[2]}\n" if m
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
  
  # Return the value of an attribute converted to a Date object. This returns
  # only the first element of the attribute value. It is
  # preferred not to use this method directly.
  #
  # ==== Parameters
  # attr_name<Symbol>:: Matches the method name
  def attr_date(attr_name)
    attrs[attr_names[attr_name]] ? Date.parse(attrs[attr_names[attr_name]][0]) : nil
  end
  
  # Return all values of an attribute as an Array. It is
  # preferred not to use this method directly.
  #
  # ==== Parameters
  # attr_name<Symbol>:: Matches the method name
  def attr_array(attr_name)
    attrs[attr_names[attr_name]] || []
  end
  
  private :attr_single, :attr_date, :attr_array
  
  # Return the whois_server used for getting details for this domain. For many
  # TLD's, all data is served from the primary whois server. A few TLD's have
  # details on separate servers. Return +host+ unless a whois_server is included
  # in the whois data.
  def whois_server
    attr_single(:whois_server) || host
  end
  
  # Name of this domain's Registrar
  def registrar_name
    attr_single(:registrar_name)
  end
  
  # Date of domain registration
  def created_on
    attr_date(:created_on)
  end
  
  # Last time the domain's whois information was updated (I think)
  def updated_on
    attr_date(:updated_on)
  end
  
  # Date domain's registration expires
  def expires_on
    attr_date(:expires_on)
  end
  
  # Array of status entries for domain
  def status
    attr_array(:status)
  end
  
  # Array of name servers for domain
  def name_servers
    attr_array(:name_servers)
  end
  
  # ID of this domain's Registrant
  def registrant_id
    attr_single(:registrant_id)
  end

  # ID of this domain's Admin contact
  def administrative_id
    attr_single(:administrative_id)
  end

  # Alias for +name_servers+
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
