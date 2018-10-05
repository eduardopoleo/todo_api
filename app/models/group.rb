class Group < Sequel::Model(:groups)
  def add_user(user)
    UserGroup.create(user_id: user.id, group_id: id)
  end
end