require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/flash'

enable :sessions

set :bind, '0.0.0.0'  # bind to all interfaces

configure :development, :test do
  require 'pry'
end

configure do
  set :views, 'app/views'
end

Dir[File.join(File.dirname(__FILE__), 'app', '**', '*.rb')].each do |file|
  require file
  also_reload file
end

post '/seats' do
  content_type :json
  payload = JSON.parse(request.body.read)
  SeatService.get(payload['layout'], payload['total_passengers'])
end
