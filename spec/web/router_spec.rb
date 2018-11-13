# frozen_string_literal: true
require 'web_helper'

describe Web::Router do
  describe '#config' do
    let(:routes) do
      [{ verb: 'get', path: '/users', controller: 'users#index' }]
    end

    context 'when building 1 get route' do
      let(:subject) { described_class.new }

      before do
        subject.config do
           get '/users', to: 'users#index'
        end
      end

      it 'when handling a get route' do
        expect(subject.routes).to match_array(routes)
      end
    end
  end
end