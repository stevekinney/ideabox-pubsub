require 'json'

class IdeaBox < Sinatra::Base

  get '/' do
    erb :index
  end
  
  post '/idea.json' do
    # Make believe we store it in a database and validate it or whatnot.
    params.to_json
  end

  run! if app_file == $0
end
