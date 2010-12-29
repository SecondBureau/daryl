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
  property :domain, String
  property :agent, String
  property :uri, Text
  property :sent_at, DateTime
  property :return_code, String
  property :created_at, DateTime
  property :updated_at, DateTime
end

DataMapper.auto_upgrade!


### CONTROLLER ACTIONS

get '/' do 
  "Hello from sinatra on heroku!"
end


