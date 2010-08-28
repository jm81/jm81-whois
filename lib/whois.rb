require 'socket'
require 'date'
require 'time'

module Whois
  class LookupRestricted < StandardError
  end
end

require 'whois/version'
require 'whois/domain'
