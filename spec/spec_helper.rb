require 'rubygems'
require 'bundler'
require 'active_support/all'

Bundler.require

Dir["spec/support/**/*.rb"].each {|f| require f}
