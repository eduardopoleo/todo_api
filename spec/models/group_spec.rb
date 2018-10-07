# frozen_string_literal: true
require 'spec_helper'

describe Group do
  describe 'add_user' do
    let!(:group) { create(:group) }
    let!(:user) { create(:user) }

    subject { group.add_user(user) }

    it 'creates the user group record' do
      expect { subject }.to change(UserGroup, :count).by(1)
      expect(UserGroup.last.user_id).to eq(user.id)
      expect(UserGroup.last.group_id).to eq(group.id)
    end
  end

  describe 'add_group' do
    let!(:group) { create(:group) }
    let!(:list) { create(:list) }

    it 'add the list to the group' do
      group.add_list(list)
      expect(list.group).to eq(group)
    end
  end
end