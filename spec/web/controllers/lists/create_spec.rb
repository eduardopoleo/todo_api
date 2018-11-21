# frozen_string_literal: true
require 'web_helper'

describe ListsController::Create do
  include Rack::Test::Methods

  def app
    EntryPoint.new
  end

  before do
    user = create(:user, name: 'miguel', email: 'miguel@gmail.com')
    env "rack.session", { user_id: user.id }
  end

  it 'creates a list' do
    expect {
      post '/lists', name: 'my_list'
    }.to change(List, :count).by(1)
  end

  it 'sets the name of the list' do
    post '/lists', name: 'my_list'
    expect(List.last.name).to eq('my_list')
  end

  it 'returns 201 and the list properties' do
    payload = {
      name: 'my_list',
      id: Integer,
      created_at: String
    }

    post '/lists', name: 'my_list'
    expect(last_response.body).to match_json_expression(payload)
    expect(last_response.status).to eq(201)
  end
end