require 'sinatra'
require 'retort'

Retort::Service.configure do |c|
 c.url = "http://localhost/RPC2"
end

get '/' do
  redirect to('/torrents')
end

post '/create' do
  Retort::Torrent.load(params[:url])
  redirect to('/')
end

get '/torrents' do
  redirect to('/torrents/main')
end

get '/torrents/:view' do
  @torrents = Retort::Torrent.all params[:view]
  erb :index
end

get '/torrents/:id/:action' do
  t = Retort::Torrent.action params[:action], params[:id]
  redirect to('/')
end
