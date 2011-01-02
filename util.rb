module Daryl
  module Tools
    def collection_inspect(delay = 100)
      new_items = self.all(:created_at.gt => Time.now - delay )
      updated_items = self.all(:updated_at.gt => Time.now - delay, :created_at.lt => Time.now - delay )
      %w[new updated].each do |t|
        collection = eval "#{t}_items"
        puts "#{collection.count} #{t} #{self.name}"
        collection.each {|o| puts "  -  #{o.name} => #{o.signature}"}
      end
    end
  end
end


Bot.send :extend, Daryl::Tools
Os.send :extend, Daryl::Tools

class Page
  def self.learn
    all(:sent_at.not => nil, :return_code => ['3','4']).each {|p| "#{p.id} #{p.return_code} #{p.host} #{p.agent} #{p.updated_at.to_s}\n" }
  end
end