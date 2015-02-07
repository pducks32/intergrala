require "sinatra/base"

module Intergrala

  class Engine < Sinatra::Base
    get '/' do
      'Hello world!'
    end
  end
end
