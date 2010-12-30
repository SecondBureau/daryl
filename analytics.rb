require 'socket'
class Page

  

  def is_os?
    Os.all.each do |os|
      r = Regexp.new(os.signature)
      return true unless r.match(self.agent).nil?
    end
    false
  end
  
  def send_to_ga
    @account = Account.first(:domain => self.host)
    if @account.nil?
      puts "#{self.host} not found"
      self.return_code = 3
      return
    end
    
    @bot = Bot.find_by_agent(self.agent)
    if @bot.nil?
      puts "#{self.agent} not found"
      self.return_code = 4
      return
    end
	
	  puts gaurl
	
  end
  
  def gaurl
    now = Page.last.created_at.to_time.to_i
    r   = rand(1000000000) + 1000000000
    server = Socket.getaddrinfo(self.ip || '0.0.0.0', 0, Socket::AF_UNSPEC, Socket::SOCK_STREAM, nil, Socket::AI_CANONNAME)[0][2]
      
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
		url +=  "&utmac=#{self.account.gacode}"
		url +=  "&utmcc=__utma%3D#{@account.utma}.#{r}.#{now}.#{now}.#{now}.1%3B%2B__utmb%3D#{@account.utma}%3B%2B__utmc%3D#{@account.utma}%3B%2B__utmz%3D#{@account.utma}.#{now}.1.1.utmccn%3D(organic)%7Cutmcsr%3D#{@bot.name}%7Cutmctr%3D#{self.uri}%7Cutmcmd%3Dorganic%3B%2B__utmv%3D#{@account.utma}.Robot%20hostname%3A%20#{server}%3B"
		url
  end
  
end

class Bot
  def self.find_by_agent(agent)
    Bot.all.each do |bot|
      r = Regexp.new(bot.signature)
      return bot unless r.match(agent).nil?
    end
    nil
  end
end
