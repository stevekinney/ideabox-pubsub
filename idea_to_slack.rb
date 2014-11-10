require 'redis'
require 'faraday'
require 'json'

redis = ENV['SLACKER_REDIS'] ? Redis.new(url: ENV['SLACKER_REDIS']) : Redis.new

conn = Faraday.new(:url => 'https://hooks.slack.com')


begin
  puts 'Hey, I like to take whatever you say on Slacker & share it on Slack.'
  puts "Press Ctrl-C at any time to exit.\n"
  
  redis.subscribe(:ideas) do |on|
    on.message do |channel, msg|
      idea = JSON.parse(msg)
      
      puts idea
      
      data = {
        username: 'Ideabox!',
        icon_url: "http://robohash.org/ideabox.png",
        text: idea['idea']
      }
      
      conn.post do |req|
        req.url "/services/#{ENV['SLACKER_WEBHOOK']}"
        req.headers['Content-Type'] = 'application/json'
        req.body = data.to_json
      end
    end
  end
rescue Interrupt => e
  puts "\nGoodbye."
end
