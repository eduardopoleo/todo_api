# frozen_string_literal: true
require 'web_helper'

describe InvitationsController::Create do
  describe '.handle' do
    subject { described_class.handle(params) }

    let(:params) { { email: 'eduardo@gmail.com'} }
    
    it 'creates the invitation' do
      expect {
        subject
      }.to change(Invitation, :count)
    end

    context 'when group_id is provided' do
      let(:params) { { email: 'eduardo@gmail.com', group_id: group.id } }
      let(:group) { create(:group) }

      it 'associates the invitation to the group' do
        subject
        expect(Invitation.last.group).to eq(group)
      end
    end
  end
end