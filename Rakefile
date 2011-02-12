require 'daryl.rb'
    
desc "GA integration"
task :cron do
  require 'analytics'
  pages = Page.all(:sent_at => nil)
  n = pages.count
  while n > 0 do
    p =  pages[rand(n)]
    p.sent_at = Time.now
    p.save
    begin
    if p.is_os?
      #puts "#{p.id} n'est pas Bot"
      p.return_code = 2
    elsif p.is_ping?
      #puts "#{p.id} est un ping"
      p.return_code = 6
    else
      #puts "#{p.id} send to ga"
      p.send_to_ga
    end
    p.sent_at = Time.now
    p.save
    rescue
      p.return_code = 5
      p.save
    end
    pages = Page.all(:sent_at => nil)
    n = pages.count
  end
  
  Page.purge_sent_pages('200')
  Page.purge_sent_pages('2')
  Page.purge_sent_pages('6')
end


desc "Debug page 200"
task :agent200 do
  require 'analytics'
  Page.all(:return_code => '200').each do |a| 
    bot = Bot.find_by_agent(a.agent)
    puts "#{a.agent} (#{a.ip} - #{a.getaddrinfo}) ==> #{bot.name}" unless bot.name.eql?('New Relic Pinger')
  end
end


namespace :db do
  
  desc "Load Database"
  task :seed do

        require 'inflectors.rb'
        require 'util.rb'
        seeds_path = File.join(File.dirname(__FILE__), 'seeds')
        
        # YAML Files
        Dir["#{seeds_path}/*"].select { |file| /(yml)$/ =~ file }.sort.each do |file|
          klass = File.basename(file, '.yml').gsub(/[0-9]+\-/,'').constantize
          YAML::load(ERB.new(IO.read(file)).result).each  do |key, params|
            conditions = {}
            klass = params['type'].constantize unless params['type'].nil?
            unless params['uniq'].nil?
              params['uniq'] = [params['uniq']] unless params['uniq'].is_a?(Array)
              params['uniq'].each {|c| conditions[c.to_sym] = params[c]}
              params.delete('uniq')
              o = klass.first(conditions) || klass.new
            else
              o = klass.new
            end
            params.each do |att, val|
              o.send("#{att}=", val)
            end
            o.save
          end
        end
        
        # ruby files
        Dir["#{seeds_path}/*"].select { |file| /(rb)$/ =~ file }.sort.each {|f| require f}

        puts Account.all(:created_at.gt => Time.now - 100 ).inspect
        Os.collection_inspect
        Bot.collection_inspect

  end
end
