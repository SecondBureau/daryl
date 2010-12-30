require 'daryl.rb'
    
desc "GA integration"
task :cron do
puts "ok"
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
    Dir["#{seeds_path}/*"].select { |file| /(rb)$/ =~ file }.sort.each {require file}
end

puts Account.all.inspect

  end
end
