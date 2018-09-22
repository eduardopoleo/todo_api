require 'rails_helper'

RSpec.describe ListsController, :type => :request do

  describe '#create' do
    let(:user) { create(:user) }

    it 'creates the list' do
      expect { 
        post '/lists', params: { name: 'my_list' }
      }.to change(List, :count).by(1)
    end
  end
end