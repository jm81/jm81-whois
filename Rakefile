require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rubygems'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "jm81-whois"
    gem.summary = %Q{Ruby library for accessing Whois information}
    gem.description = <<EOF
This library presents whois information for domains in a variety of TLD's 
through a standardized API.
EOF
    gem.email = "jmorgan@morgancreative.net"
    gem.homepage = "http://github.com/jm81/whois"
    gem.authors = ["Jared Morgan"]
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the whois gem.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib' << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end
  
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Whois #{version}'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
