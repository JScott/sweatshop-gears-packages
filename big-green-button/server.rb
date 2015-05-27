#!/usr/bin/env ruby
require 'robot_sweatshop/config'
require 'sinatra'
require 'erubis'

configure do
  set :port, ARGV[0] || 8081
  set :bind, configatron.http_bind
end

get '/' do
  html = File.read "#{__dir__}/index.html"
  eruby = Erubis::Eruby.new html
  jobs = `sweatshop job-list`.split "\n"
  context = {jobs: jobs}
  return eruby.result(context)
end
