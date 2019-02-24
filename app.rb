require 'sinatra/base'
require 'sinatra/activerecord'
Dir['./app/models/**/*.rb'].each { |file| require file }

class App < Sinatra::Base
  get '/' do
    { hello: 'world' }.to_json
  end
end
