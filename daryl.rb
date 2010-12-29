require 'rubygems'
require 'sinatra'
require 'datamapper'

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite3://my.db')

### MODELS

class Bot
  include DataMapper::Resource  
  property :id,   Serial
  property :name, String,        :length => 200
  property :signature, String,   :length => 200
  property :created_at, DateTime
  property :updated_at, DateTime
end

class Os
include DataMapper::Resource  
  property :id,   Serial
  property :name, String,   :length => 200
  property :signature, String
  property :created_at, DateTime
  property :updated_at, DateTime
end

class Account
include DataMapper::Resource  
  property :id,  Serial
  property :domain, String,   :length => 200
  property :gacode, String,   :length => 200
  property :utma  , String,   :length => 200
  property :created_at, DateTime
  property :updated_at, DateTime
end

class Page
include DataMapper::Resource  
  property :id,   Serial
  property :host, String,         :length => 200
  property :agent, String,        :length => 200
  property :uri, Text
  property :sent_at, DateTime
  property :return_code, String,  :length => 200
  property :created_at, DateTime
  property :updated_at, DateTime
end

DataMapper.auto_upgrade!


### CONTROLLER ACTIONS

get '/' do 
  "Hello from sinatra on heroku!"

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

