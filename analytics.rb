class Page
  def is_os?
    Os.all.each do |os|
      r = Regexp.new(os.signature)
      return true unless r.match(agent).nil?
    end
    false
  end
  
  def send_to_ga
    account = Account.first(:domain => host)
    if account.nil?
      puts "#{host} not found"
      return_code = 3
      return
    end
    
    bot = Bot.find_by_agent(agent)
    if bot.nil?
      puts "#{agent} not found"
      return_code = 4
      return
    end
    
    puts bot.inspect
    
    now = Time.now.to_i
    r   = rand(1000000000) + 1000000000
    server = 'titi' #gethostbyaddr( $_SERVER['REMOTE_ADDR'] )
      
    url =   'http://www.google-analytics.com/__utm.gif?'
    url +=  'utmwv=1'
    url +=  "&utmn=#{rand(8999999999) + 1000000000}"		
    url +=  '&utmsr=-'						# Screen size
		url +=  '&utmsc=-'				    # Screen quality
		url +=  '&utmul=-'					  # Language
		url +=  '&utmje=0'						# Java enabled
		url +=  '&utmfl=-'					  # Flash version	
		url +=  '&utmdt='				      # Page
		url +=  "&utmhn=#{host}"      # Host
		url +=  '&utmr=-'             # Referrer
		url +=  "&utmp=#{uri}"
		url +=  "&utmac=#{account.gacode}"
		url +=  "&utmcc=__utma%3D#{account.utma}.#{r}.#{now}.#{now}.#{now}.1%3B%2B__utmb%3D#{account.utma}%3B%2B__utmc%3D#{account.utma}%3B%2B__utmz%3D#{account.utma}.#{now}.1.1.utmccn%3D(organic)%7Cutmcsr%3D#{bot.name}%7Cutmctr%3D#{uri}%7Cutmcmd%3Dorganic%3B%2B__utmv%3D#{account.utma}.Robot%20hostname%3A%20#{server}%3B"
		
		puts "#{agent} : #{url}"
  end
  
end

class Bot
  def self.find_by_agent(agent)
    Bot.all.each do |bot|
      puts bot.signature
      #r = Regexp.new(bot.signature)
      #return bot unless r.match(agent).nil?
    end
    nil
  end
end
