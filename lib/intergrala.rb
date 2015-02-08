require "sinatra/base"
require 'json'

module Intergrala

  class Engine < Sinatra::Base

    set :public_folder, 'dist'

    get '/' do
      send_file File.join(settings.public_folder, 'index.html')
    end

    post '/equation' do
      content_type :json
      request.body.rewind
      data = JSON.parse(request.body.read)
      data.to_json
    end
  end
end
