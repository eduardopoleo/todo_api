require 'web_helper'

describe UsersController::Login do
  include Rack::Test::Methods

  def app
    EntryPoint.new
  end

  context 'when the user does not exist' do
    it 'returns 401 and a failed message' do
      post '/login', email: 'juan@gmail.com', password: 'password'

      expect(last_response.status).to eq(401)
      expect(last_response.body).to eq('There seems to be a problem with you password or email. Try again')
    end
  end

  context 'when the user exist' do
    let!(:user) do
      create(:user, 
        email: 'juan@gmail.com', 
        password_digest: BCrypt::Password.create('secure_password')
      )
    end

    context 'when the password does not match' do
      it 'returns 401 and a failed message' do
        post '/login', email: 'juan@gmail.com', password: 'password'

        expect(last_response.status).to eq(401)
        expect(last_response.body).to eq('There seems to be a problem with you password or email. Try again')
      end
    end

    context 'when the password matches' do
      it 'returns 201 and a success message' do
        post '/login', email: 'juan@gmail.com', password: 'secure_password'

        expect(last_response.status).to eq(201)
        expect(last_response.body).to eq("You've successfully logged in")
      end

      it 'sets the session id to the logged in user id' do
        post '/login', email: 'juan@gmail.com', password: 'secure_password'

        expect(last_request.session[:user_id]).to eq(user.id)
      end
    end
  end
end