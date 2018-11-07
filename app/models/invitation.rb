require 'securerandom'

class Invitation < Sequel::Model(:invitations)
  many_to_one :group

  def self.create(user_id: nil, group_id: nil, email: nil)
    token = SecureRandom.base64

    params = {
      group_id: group_id,
      token: token,
      email: email
    }

    super(params)
  end
end