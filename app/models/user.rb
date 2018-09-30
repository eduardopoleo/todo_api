class User < Sequel::Model(:users)
  def self.create(name:, email:, password:)
    encypted_password = BCrypt::Password.create(password)
    created_at = Time.now

    params = {
      name: name,
      email: email,
      password_digest: encypted_password,
      created_at: created_at,
      updated_at: created_at
    }

    id = dataset.insert(params)
    user = User.new(params).tap { |u| u.id = id }
  end
end