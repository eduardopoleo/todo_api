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
  end

  describe '#outstading_tasks' do
    let!(:user) { create(:user) }

    let!(:task1) { create(:task, completed: false) }
    let!(:task2) { create(:task, assignee_id: user.id, completed: true) }
    let!(:task3) { create(:task, assignee_id: user.id, completed: false) }
  
    subject { user.outstading_tasks }

    it 'only returns the tasks not completed by the user' do
      expect(subject).to match_array([task3])
    end
  end

  describe '#create_group' do
    let(:user) { create(:user) }

    subject { user.create_group('Super group') }

    it 'only returns the tasks not completed by the user' do
      expect { subject }.to change(Group, :count).by(1)
    end
  end
end