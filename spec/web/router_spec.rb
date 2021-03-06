# frozen_string_literal: true
require 'web_helper'

describe Router do
  describe '#config' do
    let(:subject) { described_class.new }

    context 'when building get routes' do
      before do
        subject.config do
          get '/users', to: 'users#index'
        end
      end

      let(:routes) { [{ verb: 'get', path: '/users', controller: 'users#index' }] }

      it 'adds a GET route to the routes instance variable' do
        expect(subject.routes).to match_array(routes)
      end
    end

    context 'when building post route' do
      before do
        subject.config do
          post '/users', to: 'users#create'
        end
      end

      let(:routes) { [{ verb: 'post', path: '/users', controller: 'users#create' }] }

      it 'adds a POST route to the routes instance variable' do
        expect(subject.routes).to match_array(routes)
      end
    end

    context 'when building patch route' do
      before do
        subject.config do
          patch '/users', to: 'users#update'
        end
      end

      let(:routes) { [{ verb: 'patch', path: '/users', controller: 'users#update' }] }

      it 'adds a POST route to the routes instance variable' do
        expect(subject.routes).to match_array(routes)
      end
    end 

    context 'when building put route' do
      before do
        subject.config do
          put '/users', to: 'users#update'
        end
      end

      let(:routes) { [{ verb: 'put', path: '/users', controller: 'users#update' }] }

      it 'adds a POST route to the routes instance variable' do
        expect(subject.routes).to match_array(routes)
      end
    end

    context 'when building delete route' do
      before do
        subject.config do
          delete '/users', to: 'users#update'
        end
      end

      let(:routes) { [{ verb: 'delete', path: '/users', controller: 'users#update' }] }

      it 'adds a POST route to the routes instance variable' do
        expect(subject.routes).to match_array(routes)
      end
    end

    context 'when there are several routes' do
      before do
        subject.config do
          delete '/users', to: 'users#destroy'
          get '/users', to: 'users#index'
          patch '/users', to: 'users#update'
        end
      end

      let(:routes) do 
        [
          { verb: 'delete', path: '/users', controller: 'users#destroy' },
          { verb: 'get', path: '/users', controller: 'users#index' },
          { verb: 'patch', path: '/users', controller: 'users#update' }
        ]
      end

      it 'adds a POST route to the routes instance variable' do
        expect(subject.routes).to match_array(routes)
      end
    end
  end
  
  describe 'match' do
    context 'when the route provided matches a route in the config' do
      before do
        subject.config do
          patch '/users', to: 'users#update'
        end
      end

      let(:route) { { verb: 'patch', path: '/users', controller: 'users#update' } }

      it 'returns a route object with the correct information' do
        expect(subject.match('patch', '/users')).to eq(route)
      end
    end

    context 'when theres not match' do
      it 'returns a route object with the correct information' do
        expect(subject.match('patch', '/users')).to be_nil
      end
    end
  end

  describe 'execute' do
    context 'when the controller class exist' do
      let(:env) { Rack::MockRequest.env_for('/some_url', options) }
        
      let(:options) do
        {
          method: :get,
          params: {},
          'CONTENT-TYPE' => 'application/json'
        }
      end

      let(:req) { Rack::Request.new(env) }

      it 'handles the response with the corresponding controller' do

        module SomeController 
          class Action < BaseController
            def handle
            end
          end
        end

        expect_any_instance_of(SomeController::Action).to receive(:handle)
        subject.execute('some#action', req)
      end
    end
  end
end