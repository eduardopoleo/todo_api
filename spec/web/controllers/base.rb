# frozen_string_literal: true
require 'web_helper'

describe BaseController do
  describe '.before_action' do
    subject { described_class.before_action :authenticate }

    it 'saves the call back' do
      subject
      expect(described_class.before_actions).to include(:authenticate)
    end

    context "when it's enhirited" do
      it 'passes down the call backs to child clasess' do
        subject

        class TestController1 < BaseController
        end

        expect(TestController1.before_actions).to include(:authenticate)
      end
    end
  end

  describe '#execute' do
    context 'when there are not before action callbacks' do
      class TestController2 < BaseController
        def handle
          [200, {}, ['Authorized']]
        end
      end

      it 'returns the handle response' do
        expect(TestController2.new({}).execute).to eq([200, {}, ['Authorized']])
      end
    end

    context 'when there are before action callbacks' do
      class TestController3 < BaseController
        before_action :authenticate

        def handle
          [200, {}, ['Authorized']]
        end

        def authenticate
          halt 401, 'Unauthorized' unless params[:valid]
        end
      end

      context 'when the callback does not stop execution' do
        let(:params) { { valid: true} }
        it 'return response from handle' do
          expect(TestController3.new(params).execute).to eq([200, {}, ['Authorized']])
        end
      end

      context 'when the callback stops execution' do
        let(:params) { { valid: false } }
        it 'returns response from the callback' do
          expect(TestController3.new(params).execute).to eq([401, {}, ['Unauthorized']])
        end
      end
    end

    context 'when child controller has not defined handle' do
      class TestController4 < BaseController
      end

      it 'reaises an exception' do
        expect { TestController4.new({}).execute }.to raise_error(BaseController::HandlerNotDefined )
      end
    end
  end
end