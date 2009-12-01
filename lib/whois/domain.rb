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

require 'whois/domain/base.rb'
Dir.new(File.dirname(__FILE__) + '/domain').each do |file|
  require('whois/domain/' + File.basename(file)) if File.extname(file) == ".rb"
end
