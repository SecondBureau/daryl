require 'rubygems'
require 'sinatra'
require 'datamapper'

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite3://my.db')

### MODELS

class Bot
  include DataMapper::Resource  
  property :id,   Serial
  property :name, String
  property :signature, String
  property :created_at, DateTime
  property :updated_at, DateTime
end

class Os
include DataMapper::Resource  
  property :id,   Serial
  property :name, String
  property :signature, String
  property :created_at, DateTime
  property :updated_at, DateTime
end

class Account
include DataMapper::Resource  
  property :id,  Serial
  property :domain, String
  property :gacode, String
  property :utma  , String
  property :created_at, DateTime
  property :updated_at, DateTime
end

class Page
include DataMapper::Resource  
  property :id,   Serial
  property :host, String
  property :agent, Text
  property :uri, Text
  property :ip, String
  property :sent_at, DateTime
  property :return_code, String
  property :created_at, DateTime
  property :updated_at, DateTime
end

DataMapper.auto_upgrade!

### New Relic
configure :production do 
  require 'newrelic_rpm'
end


### CONTROLLER ACTIONS

get '/' do 
  "Hello from sinatra on heroku!"
end

get '/newrelic_daryl' do |c|
  "newrelic OK"
end

post '/page/create' do
puts params[:page].inspect
  page = Page.new(params[:page])
  if page.save
    status 201
    "OK"
    page.inspect
  else
    status 412
    "KO"
  end
end

