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
    let!(:user) { 'store@rubyscraping.com' }

    describe 'GET /' do
      before { get '/', {}, {'rack.session' => {user: user}} }
      
      it { expect(last_response).to be_ok }
    end

    describe 'GET /login' do
      before do
        get '/login', {}, {'rack.session' => {user: user}}
        follow_redirect!
      end

      it { expect(last_response).to be_ok }
      it { expect(last_request.url).to eq 'http://example.org/' }
    end

    describe 'GET /logout' do
      before do
        get '/logout', {}, {'rack.session' => {user: user}}
        follow_redirect!
      end

      it { expect(last_response).to be_ok }
      it { expect(last_request.url).to eq 'http://example.org/login' }    
    end

    describe 'POST /login' do
      before do
        post '/login', {login: 'store@rubyscraping.com', password: 'p455woRd'}, {'rack.session' => {user: user}}
        follow_redirect!
      end

      it { expect(last_response).to be_ok }
      it { expect(last_request.url).to eq 'http://example.org/' }   
    end
  end

  context 'logged out' do
    describe 'GET /' do
      before do
        get '/'
        follow_redirect!
      end

      it { expect(last_response).to be_ok }
      it { expect(last_request.url).to eq 'http://example.org/login' }
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

      it { expect(last_response).to be_ok }
      it { expect(last_request.url).to eq 'http://example.org/login' }
    end

    describe 'POST /login' do
      before do
        post '/login', {login: 'store@rubyscraping.com', password: 'p455woRd'}
        follow_redirect!
      end

      it { expect(last_response).to be_ok }
      it { expect(last_request.url).to eq 'http://example.org/' }
    end
  end
end
