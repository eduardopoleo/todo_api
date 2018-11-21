# frozen_string_literal: true
require 'web_helper'

describe UsersController::Logout do
  include Rack::Test::Methods

  def app
    EntryPoint.new
  end

  before { env "rack.session", { user_id: 4 } }

  it 'sets the session user_id to nil' do
    post '/logout'

    expect(last_request.session[:user_id]).to be_nil
    expect(last_response.body).to eq("You've successfully logged out")
    expect(last_response.status).to eq(200)
  end
end