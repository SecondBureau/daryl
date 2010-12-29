require 'net/http'
require 'uri'

#url = 'http://stark-frost-232.heroku.com/page/create'
url = 'http://localhost:4567/page/create'

#get
#Net::HTTP.get_print URI.parse(url)

#post
res = Net::HTTP.post_form(URI.parse(url),
                              { 'page[agent]'=>'toto'})
puts res.body
