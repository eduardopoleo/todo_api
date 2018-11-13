# frozen_string_literal: true
require 'web_helper'

describe Web::App do
  let(:env) { Rack::MockRequest.env_for(url, options) }
    
  let(:options) do
    {
      method: method,
      params: params,
      'CONTENT-TYPE' => 'application/json'
    }
  end

  class Web::Controllers::Users::Create
    def self.handle(params)
    end
  end

  class Web::Controllers::Users::Index
    def self.handle(params)
    end
  end

  AppRouter = Web::Router.new

  before do
    AppRouter.config do
      post '/users', to: 'users#create'
      get '/users', to: 'users#index'
    end
  end
  
  context 'when the route is defined' do
    context 'when handling a post request' do
      let(:method) { :post }
      let(:params) { "{\"key1\":\"value1\", \"key2\":\"value2\"}" }
      let(:url) { 'http://example.com:9393/users' }

      it 'calls the correct controller' do
        expect(Web::Controllers::Users::Create).to receive(:handle).with(JSON.parse(params))
        described_class.new.call(env)
      end
    end

    context 'when handling a get request' do
      let(:method) { :get }
      let(:params) { '' }
      let(:url) { 'http://example.com:9393/users?name=eduardo&email=eduardo@influitive.com' }

      it 'calls the correct controller' do
        expect(Web::Controllers::Users::Index)
          .to receive(:handle)
          .with({'name' => 'eduardo', 'email' => 'eduardo@influitive.com' })

        described_class.new.call(env)
      end
    end
  end

  context 'when the route is not defined' do
    let(:method) { :post }
    let(:params) { "{\"nothing\":\"of_value\", \"cool\":\"beans\"}" }
    let(:url) { 'http://example.com:9393/some_weird_stupid_url' }

    it 'returns a 404' do
      status, header, body = described_class.new.call(env)

      expect(status).to eq(404)
      expect(header).to eq({ 'Content-Type' => 'text/html' })
      expect(body).to eq(['Not Found'])
    end
  end
end