require 'sinatra/base'

class Dashboard < Sinatra::Base

  get '/login' do
    'login'
  end

  get '/' do
    'dashboard'
  end

  get '/logout' do
    'logout'
  end
end
