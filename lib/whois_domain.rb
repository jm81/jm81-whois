module Whois::Domain
  TLD = {
    "VerisignGrs" => [:com, :net],
    "PublicInterest" => [:org],
    "Neustar" => [:biz, :us],
    "Aero" => [:aero],
    "Afilias" => [:info],
    "Cat" => [:cat],
    "Coop" => [:coop]
  }

  def self.new(domain_name)
    tld = domain_name.match(/.*\.([^\.]+)$/)[1].to_sym
    class_name = TLD.find{|c, tlds| tlds.include?(tld)}[0]
    const_get(class_name).new(domain_name)
  end
end

require "#{File.dirname(__FILE__)}/domain/base.rb"
Dir["#{File.dirname(__FILE__)}/domain/*.rb"].sort.each { |ext| require ext }