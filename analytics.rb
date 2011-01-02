require 'socket'
require 'curb'
require 'cgi'

class Page

  def is_os?
    Os.all.each do |os|
      r = Regexp.new(os.signature, true)
      return true unless r.match(self.agent).nil?
    end
    false
  end
  
  def send_to_ga
    @account = Account.first(:domain => self.host)
    if @account.nil?
      #puts "#{self.host} not found"
      self.return_code = 3
      return
    end
    
    @bot = Bot.find_by_agent(self.agent)
    if @bot.nil?
      #puts "#{self.agent} not found"
      self.return_code = 4
      return
    end
	
	 curl_handler = Curl::Easy.new(gaurl)
   curl_handler.http_get
   self.return_code = curl_handler.response_code
	 #puts "#{@bot.name} #{self.uri} #{self.return_code}"
	
  end
  
  def getaddrinfo
    Socket.getaddrinfo(self.ip || '0.0.0.0', 0, Socket::AF_UNSPEC, Socket::SOCK_STREAM, nil, Socket::AI_CANONNAME)[0][2] 
  end
  
  def gaurl
    now = Page.last.created_at.to_time.to_i
    r   = rand(1000000000) + 1000000000
    server = CGI::escape(getaddrinfo)
      
    url =   'http://www.google-analytics.com/__utm.gif?'
    url +=  'utmwv=1'
    url +=  "&utmn=#{rand(8999999999) + 1000000000}"		
    url +=  '&utmsr=-'						# Screen size
		url +=  '&utmsc=-'				    # Screen quality
		url +=  '&utmul=-'					  # Language
		url +=  '&utmje=0'						# Java enabled
		url +=  '&utmfl=-'					  # Flash version	
		url +=  '&utmdt='				      # Page
		url +=  "&utmhn=#{self.host}"      # Host
		url +=  '&utmr=-'             # Referrer
		url +=  "&utmp=#{self.uri}"
		url +=  "&utmac=#{@account.gacode}"
		url +=  "&utmcc=__utma%3D#{@account.utma}.#{r}.#{now}.#{now}.#{now}.1%3B%2B__utmb%3D#{@account.utma}%3B%2B__utmc%3D#{@account.utma}%3B%2B__utmz%3D#{@account.utma}.#{now}.1.1.utmccn%3D(organic)%7Cutmcsr%3D#{CGI::escape(@bot.name)}%7Cutmctr%3D#{CGI::escape(self.uri)}%7Cutmcmd%3Dorganic%3B%2B__utmv%3D#{@account.utma}.Robot%20hostname%3A%20#{server}%3B"
		url
  end
  
  def self.purge_sent_pages(return_code = nil)
    Page.all({:sent_at.lt => Time.now - 60*60*2, :return_code => '200'}).destroy
  end
  
end

class Bot
  def self.find_by_agent(agent)
    Bot.all.each do |bot|
      r = Regexp.new(bot.signature, true)
      return bot unless r.match(agent).nil?
    end
    bot = Bot.first(:name => 'Unknown Robot')
    r = Regexp.new('(robot|spider|harvest|bot|crawler)', true))
    return bot unless r.match(agent).nil?
    nil
  end
end
