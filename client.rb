require 'net/http'
require 'uri'

url = 'http://http://stark-frost-232.heroku.com/page/create'

#get
#Net::HTTP.get_print URI.parse(url)

#post
res = Net::HTTP.post_form(URI.parse(url),
                              {'page[name]'=>'ruby', 'page[agent]'=>'toto'})
puts res.body
