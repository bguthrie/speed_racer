begin
  require 'spec'
  require 'mocha'
rescue LoadError
  require 'rubygems'
  gem 'rspec'
  require 'spec'
  gem 'mocha'
  require 'mocha'
end

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'speed_racer'

Spec::Runner.configure do |config|
  config.mock_with :mocha
end