require "sinatra/base"

module Intergrala

  class Engine < Sinatra::Base
    post '/equation' do
      request.body.rewind
      data = JSON.parse request.body.read
      data
    end
  end
end
