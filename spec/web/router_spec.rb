# frozen_string_literal: true
require 'web_helper'

describe Web::Router do
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
end