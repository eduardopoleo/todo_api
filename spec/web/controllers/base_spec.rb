# frozen_string_literal: true
require 'web_helper'

describe BaseController do
  after { BaseController.before_actions.clear }

  describe '.before_action' do
    it 'saves the call back' do
      described_class.before_action :authenticate
      expect(described_class.before_actions).to include(:authenticate)
    end

    context "when it's inherited" do
      it 'passes down the call backs to child clasess' do
        described_class.before_action :authenticate

        class InheritedController < BaseController
        end

        expect(InheritedController.before_actions).to include(:authenticate)
      end
    end
  end

  describe '#execute' do
    context 'when there are not before action callbacks' do
      class NoCallBackController < BaseController
        def handle
          [200, {}, ['Authorized']]
        end
      end

      it 'returns the handle response' do
        expect(NoCallBackController.new({}).execute).to eq([200, {}, ['Authorized']])
      end
    end

    context 'when there are before action callbacks' do
      class CallbacksController < BaseController
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
          expect(CallbacksController.new(params).execute).to eq([200, {}, ['Authorized']])
        end
      end

      context 'when the callback stops execution' do
        let(:params) { { valid: false } }
        it 'returns response from the callback' do
          expect(CallbacksController.new(params).execute).to eq([401, {}, ['Unauthorized']])
        end
      end
    end

    context 'when child controller has not defined handle' do
      class NohandleController < BaseController
      end

      it 'reaises an exception' do
        expect { NohandleController.new({}).execute }.to raise_error(BaseController::HandlerNotDefined )
      end
    end
  end
end