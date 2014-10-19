require 'sinatra/base'

class Dashboard < Sinatra::Base
  enable :sessions

  get '/login' do
    if logged_in?
      redirect '/'
    else
      haml :login
    end
  end

  get '/logout' do
    session[:user] = nil
    redirect '/login'
  end

  get '/' do
    if logged_in?
      haml :dashboard
    else
      redirect '/login'
    end
  end

  post '/login' do
    if params[:login] == 'store@rubyscraping.com' && params[:password] == 'p455woRd'
      session[:user] = params[:login]
      redirect '/'
    else
      redirect '/login'
    end
  end

  private

  def logged_in?
    !session[:user].nil?
  end
end
