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
      raw_body = request.body.read
      answer = JSON.parse(send_to_ian_because_Jesus raw_body)
      data = JSON.parse(raw_body)
      answer = JSON.parse(answer)
      result = {latex: format(answer, data), volume: answer.volume}
      JSON.dump(result)
    end

    def send_to_ian_because_Jesus(data)
      `python python/integrala #{data}`
    end

    def format(response, request)
      latex method: response.method, expression: response.latex, volume: response.volume, dependent: request.dependentVariable, range: request.lowerBound..request.upperBound
    end

    def latex(method:, **other)
      public_send("latex_#{method}", **other)
    end

    def latex_disk(expression:, range:, volume:, dependent: "x",)
      "2\\pi \\int ^{#{range.min}}_{#{range.max}}#{expression}^{2}d#{dependent}=#{answer}"
    end

    def latex_shell(expression:, range:, volume:, dependent: "x")
      "2\\pi \\int ^{#{range.max}}_{#{range.max}}#{dependent}#{expression}dx=#{answer}"
    end
  end
end
