require 'rubygems'
require 'sinatra'
require 'data_mapper'
require 'syntaxi'

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite3://my.db')

### MODELS

class Bot < DataMapper::base
  property :name, :string
  property :signature, :string
  property :created_at, :datetime
  property :updated_at, :datetime
end

class Os < DataMapper::base
  property :name, :string
  property :signature, :string
  property :created_at, :datetime
  property :updated_at, :datetime
end

class Account < DataMapper::base
  property :domain, :string
  property :gacode, :string
  property :utma  , :string
  property :created_at, :datetime
  property :updated_at, :datetime
end

class Page < DataMapper::base
  property :domain, :string  
  property :agent, :string
  property :uri, :text
  property :sent_at :datetime
  property :return_code, :string
  property :created_at, :datetime
  property :updated_at, :datetime
end

database.table_exists?(Bot) or database.save(Bot)


### CONTROLLER ACTIONS

get '/' do 
  "Hello from sinatra on heroku!"
end


