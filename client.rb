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

 uri, agent, host = "Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/534.10 (KHTML, like Gecko) Chrome/8.0.552.224 Safari/534.10", "1234567890123456789012345678901234567890123456789", "Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/534.10 (KHTML, like Gecko) Chrome/8.0.552.224 Safari/534.10"
       
#post
res = Net::HTTP.post_form(URI.parse(url), {'page[host]'=>host, 'page[agent]' => agent, 'page[uri]' => uri})

#puts res.inspect
