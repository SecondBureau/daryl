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
      puts "#{p.id} n'est pas OS"
      p.return_code = 2
    else
      puts "#{p.id} send to ga"
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
end


desc "Debug page 200"
task :agent200 do
  Page.all(:return_code => '200').each {|a| puts "#{a.agent} ==> #{Bot.find_by_agent(a.agent)}" }
end

desc "Load Database"
namespace :db do
  task :seed do
    require 'inflectors.rb'
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
    # ruby files
    Dir["#{seeds_path}/*"].select { |file| /(rb)$/ =~ file }.sort.each {|f| require f}
end

puts Account.all.inspect

  end
end
