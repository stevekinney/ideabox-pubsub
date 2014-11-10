require 'redis'
require 'json'

$redis = ENV['SLACKER_REDIS'] ? Redis.new(url: ENV['SLACKER_REDIS']) : Redis.new

class IdeaBox < Sinatra::Base

  get '/' do
    erb :index
  end
  
  post '/idea.json' do
    # Make believe we store it in a database and validate it or whatnot.
    $redis.publish(:ideas, params.to_json)
    params.to_json
  end

  run! if app_file == $0
end
