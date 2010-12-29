require 'net/http'
require 'uri'

daryl         = ENV['DARYL'] || 'daryl.2bu.ro'
url = "http://#{daryl}/page/create"
agent, host, uri = 'test', '2bu.ro', ''
if defined? request
  agent         = request.env["HTTP_USER_AGENT"]
  host          = request.host
  uri           = request.request_uri
end

#post
res = Net::HTTP.post_form(URI.parse(url), {'page[host]'=>host, 'page[agent]' => agent, 'page[uri]' => uri})

puts res.inspect
