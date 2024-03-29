require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/flash'
require 'active_support/core_ext/hash'

enable :sessions

set :bind, '0.0.0.0'  # bind to all interfaces

configure :development, :test do
  require 'pry'
end

configure do
  set :views, 'app/views'
  set :port, (ENV["PORT"] || 4567).to_i
end

Dir[File.join(File.dirname(__FILE__), 'app', '**', '*.rb')].each do |file|
  require file
  also_reload file
end

post '/seats' do
  content_type :json
  payload = JSON.parse(request.body.read)
  SeatService.get(payload['layout'], payload['total_passengers']).to_json
rescue ::Services::BadParameterError => e
  halt 400, {error: e.message}.to_json
rescue => _e
  halt 500, {error: "Forbidden"}.to_json
end
