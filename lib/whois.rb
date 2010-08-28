require 'socket'
require 'date'
require 'time'

module Whois
  VERSION = '0.5.0'
  
  class LookupRestricted < StandardError
  end
end

require 'whois/domain'
