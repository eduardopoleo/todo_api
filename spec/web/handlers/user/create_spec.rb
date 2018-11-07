# frozen_string_literal: true
require 'web_helper'

describe Web::Handlers::Users::Create do
  describe '.handle' do
    subject { described_class.handle(params) }

    context 'with correct params' do
      let(:params) do
        {
          email: 'ines_gomes@gomesgomes.com',
          name: 'Ines Agua Clara',
          password: 'bestpassword'
        }
      end

      it 'create the user' do
        expect {
          subject
        }.to change(User, :count).by(1)
      end
    end
  end
end