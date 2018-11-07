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

      it 'creates an user' do
        expect {
          subject
        }.to change(User, :count).by(1)
      end

      it 'creates a session' do
        expect {
          subject
        }.to change(Session, :count).by(1)
      end

      let(:response) do
        [
          201,
          { 'Content-Type' => 'aplication/json' },
          user.to_hash.merge(session_token: token).to_json
        ]
      end

      let(:token) { 'some_token' }

      let(:user) { create(:user) }

      it 'returns a 201' do
        allow(User).to receive(:create) { user }
        allow(SecureRandom).to receive(:base64) { token }

        expect(subject).to eq(response)
      end
    end
  end
end