ENV['RACK_ENV'] = 'test'

require './dashboard'
require 'rspec'
require 'rack/test'

describe Dashboard do
  include Rack::Test::Methods

  def app
    Dashboard
  end

  context 'logged in' do
    describe 'GET /' do
      before { get '/' }
      
      it { expect(last_response).to be_ok }
    end

    describe 'GET /login' do
      before do
        get '/login'
        follow_redirect!
      end

      it { expect(last_response).to be_redirect }
      it { expect(last_response.url).to eq '/' }
    end

    describe 'GET /logout' do
      before do
        get '/logout'
        follow_redirect!
      end

      it { expect(last_response).to be_redirect }
      it { expect(last_response.url).to eq '/login' }    
    end

    describe 'POST /login' do
      before do
        post '/login', login: 'store@rubyscraping.com', password: 'p455woRd'
        follow_redirect!
      end

      it { expect(last_response).to be_redirect }
      it { expect(last_response.url).to eq '/dashboard' }   
    end
  end

  context 'logged out' do
    describe 'GET /' do
      before do
        get '/'
        follow_redirect!
      end

      it { expect(last_response).to be_redirect }
      it { expect(last_response.url).to eq '/login' }
    end

    describe 'GET /login' do
      before { get '/login' }

      it { expect(last_response).to be_ok }
    end

    describe 'GET /logout' do
      before do
        get '/logout'
        follow_redirect!
      end

      it { expect(last_response).to be_redirect }
      it { expect(last_response.url).to eq '/login' }
    end

    describe 'POST /login' do
      before do
        get '/login'
        follow_redirect!
      end

      it { expect(last_response).to be_redirect }
      it { expect(last_response.url).to eq '/' }
    end
  end
end
