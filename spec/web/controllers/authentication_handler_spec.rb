# frozen_string_literal: true
require 'web_helper'

describe 'Authentication' do
  include Rack::Test::Methods

  WebApp.router.config do
    get '/dummy', to: 'dummy#show'
  end

  def app
    EntryPoint.new
  end

  module DummyController
    class Show < BaseController
      include AuthenticationHandler

      def handle
        @status = 200
        @body = 'Everything is ok!'  
      end
    end
  end

  context 'when the session is not set' do
    it 'returns 401 if the session is not set' do
      get '/dummy'
      expect(last_response.status).to eq(401)
    end
  end

  context 'when the session is set' do
    before do
      env "rack.session", { user_id: create(:user).id }
    end
   
    it 'returns 200 and the corresponding body' do
      get '/dummy'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq('Everything is ok!')
    end
  end
end