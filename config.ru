require 'sinatra'
require File.join(File.dirname(__FILE__), 'app.rb')

set :environment, ENV['RACK_ENV'].to_sym
set :app_file,     'app.rb'
disable :run

log = File.new("log/sinatra.log", "a")
STDOUT.reopen(log)
STDERR.reopen(log)

run Sinatra::Application
