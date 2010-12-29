require 'rubygems'
require 'sinatra'
require 'datamapper'
require 'syntaxi'

Bundler.require

require 'daryl'
run Sinatra::Application
