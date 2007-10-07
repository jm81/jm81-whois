require 'socket'
require 'date'
require 'time'

module Whois
  
end

require File.join(File.dirname(__FILE__), 'whois_domain') unless Whois.const_defined?("Domain")
