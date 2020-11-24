require 'server'
require 'rack/test'

RSpec.describe 'aws-credentials-server' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe 'GET /' do
    it 'says its name' do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to eq 'aws-credentials-server'
    end
  end

  describe 'GET /latest/meta-data/iam/security-credentials/' do
    it 'returns the credential name' do
      get '/latest/meta-data/iam/security-credentials/'
      expect(last_response).to be_ok
      expect(last_response.body).to eq 'local-credentials'
    end

    it 'works without a trailing slash' do
      get '/latest/meta-data/iam/security-credentials'
      expect(last_response).to be_ok
      expect(last_response.body).to eq 'local-credentials'
    end
  end

  # describe 'GET /latest/meta-data/iam/security-credentials/local-credentials' do
  #   it 'returns temporary credentials' do
  #     # TODO
  #   end
  # end

  describe 'GET /latest/meta-data/instance-id/' do
    it 'returns aws-credentials-server' do
      get '/latest/meta-data/instance-id/'
      expect(last_response).to be_ok
      expect(last_response.body).to eq 'aws-credentials-server'
    end

    it 'works without a trailing slash' do
      get '/latest/meta-data/instance-id'
      expect(last_response).to be_ok
      expect(last_response.body).to eq 'aws-credentials-server'
    end
  end

  describe 'GET /latest/meta-data/iam/info/' do
    it 'returns success' do
      get '/latest/meta-data/iam/info/'
      expect(last_response).to be_ok
      expect(last_response.body).to eq '{"Code": "Success"}'
    end

    it 'works without a trailing slash' do
      get '/latest/meta-data/iam/info'
      expect(last_response).to be_ok
      expect(last_response.body).to eq '{"Code": "Success"}'
    end
  end

  # describe 'GET /latest/meta-data/dynamic/instance-identity/document' do
  #   # TODO
  # end
end
