module Whois::Domain
  @@tlds = {}

  def self.tlds
    @@tlds
  end

  def self.new(domain_name)
    tld = domain_name.match(/.*\.([^\.]+)$/)[1].to_sym
    class_name = @@tlds.find{|c, tlds_ary| tlds_ary.include?(tld)}[0]
    const_get(class_name).new(domain_name)
  end
end

require "#{File.dirname(__FILE__)}/domain/base.rb"
Dir["#{File.dirname(__FILE__)}/domain/*.rb"].sort.each { |ext| require ext }