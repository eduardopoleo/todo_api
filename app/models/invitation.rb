require 'securerandom'

class Invitations < Sequel::Model(:invitations)
  def self.create(user_id: nil, group_id: nil, email: nil)
    token = SecureRandom.base64

    params = {
      user_id: user_id,
      group_id: group_id,
      token: token,
      email: email
    }

    super(params)
  end
end