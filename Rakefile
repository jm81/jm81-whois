require 'rake'
require 'rake/testtask'
require 'rdoc/task'
require 'rubygems'
require File.join(File.dirname(__FILE__), 'lib', 'whois', 'version')

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
