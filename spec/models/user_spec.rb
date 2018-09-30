# frozen_string_literal: true
require 'spec_helper'

describe User do
  describe '.create' do
    let(:params) do
      {
        name: 'Jose',
        email: 'jose@gmail.com',
        password: 'my_password'
      }
    end

    subject { described_class.create(params) }

    it 'creates the user' do
      expect { subject }.to change(User, :count).by(1)
    end

    it 'has the right properties' do
      subject
      user = User.last
      expect(user.email).to eq('jose@gmail.com')
      expect(user.name).to eq('Jose')
    end
  end
end