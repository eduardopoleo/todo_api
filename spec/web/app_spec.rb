# frozen_string_literal: true
require 'web_helper'

describe Web::App do
  let(:env) { Rack::MockRequest.env_for(url, options) }
  let(:url) { 'http://example.com:9393/users' }
    
	let(:options) do
    {
      method: method,
      params: params,
      'CONTENT-TYPE' => 'application/json'
    }
  end

  context 'when the route is defined' do
    AppRouter = Web::Router.new

    before do
      AppRouter.config do
        post '/users', to: 'users#create'
      end
    end

    context 'when handling a post request' do
      let(:method) { :post }
      let(:params) { "{\"key1\":\"value1\", \"key2\":\"value2\"}" }


      it 'calls the correct controller' do
        expect(Web::Controllers::Users::Create).to receive(:handle).with(JSON.parse(params))
        described_class.new.call(env)
      end
    end
  end
end