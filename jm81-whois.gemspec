$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require 'whois/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'jm81-whois'
  s.version     = Whois::VERSION
  s.authors     = ['Jared Morgan']
  s.email       = ['jmorgan@morgancreative.net']
  s.homepage    = %q{http://github.com/jm81/whois}
  s.summary     = %q{Ruby library for accessing Whois information}
  s.description = %q{This library presents whois information for domains in a variety of TLD's
through a standardized API.
}

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile", "README.md"]
end

