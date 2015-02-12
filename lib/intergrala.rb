require "sinatra/base"
require "json"
require "intergrala/equation"
require "intergrala/program_runner"
require "intergrala/equation_runner"
require "intergrala/equation_solver"

module Intergrala

  class Engine < Sinatra::Base

    def self.run!
      super
      $logger = Intergrala::Logger.new
    end

    set :public_folder, 'dist'

    get '/' do
      $logger.log(:router, "New User Connected!")
      send_file File.join(settings.public_folder, 'index.html')
    end

    post '/equation' do
      content_type :json
      request.body.rewind
      json_data = JSON.parse request.body.read
      $logger.log(:router, "New Equation" data: json_data)
      body EquationSolver.call(json_data).to_json
      $logger.log(:router, "Equation Returned")
    end
  end

end
