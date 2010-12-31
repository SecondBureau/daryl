require 'net/http'
require 'uri'
require 'rubygems'
require 'curb'
require 'cgi'

agent = 'ZoomSpider'
host = 'local.secondbureau.com'
path = '/fr/industries'
port = 3000


url = "http://www.google-analytics.com/__utm.gif?utmwv=1&utmn=7387460183&utmsr=-&utmsc=-&utmul=-&utmje=0&utmfl=-&utmdt=&utmhn=eastasia.fr&utmr=-&utmp=/&utmac=UA-18939774-2&utmcc=__utma%3D1.1280221574.1293752687.1293 752687.1293752687.1%3B%2B__utmb%3D1%3B%2B__utmc%3D1%3B%2B__utmz%3D1.1293752687.1.1.utmccn%3D(organic)%7Cutmcsr%3D#{CGI::escape('New Relic Pinger')}%7Cutmctr%3D/%7Cutmcmd%3Dorganic%3B%2B__utmv%3D1.Robot%20hostname%3A%20#{CGI::escape('domU-12-31-39-18-0D-28.compute-1.internal')}%3B"

 curl_handler = Curl::Easy.new(url)
 curl_handler.http_get

  puts curl_handler.response_code
  
