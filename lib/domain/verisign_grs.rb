class Whois::Domain::VerisignGrs < Whois::Domain::Base
  HOST = "whois.verisign-grs.com"
  
  # based on Michael Neumann's library
  def attrs
    return @attrs if @attrs
    
    actual_object = {}
    raw.each do |i|
      if i =~ /^   ([^:]+):\W*(.*)$/
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
      if i =~ /^   ([^:]+):\W*(.*)$/
        s << "#{$1}: #{$2}\n"
      end
    end
    s
  end
  
  def database_updated_at
    if(@raw =~ /Last update of whois database: ([^<]*)/)
      Time.parse($1)
    end
  end
end