require 'net/http'
require 'uri'

agent = 'ZoomSpider'
host = 'local.secondbureau.com'
path = '/fr/industries'
port = 3000

http = Net::HTTP.new(host, port)
http.start do |http|
  req = Net::HTTP::Get.new(path, {'User-Agent' => agent})
  response = http.request(req)
  resp = response.body
  puts resp.inspect
end



