class Group < Sequel::Model(:groups)
  one_to_many :lists

  def add_user(user)
    UserGroup.create(user_id: user.id, group_id: id)
  end

  def add_list(list)
    list.update(group_id: id)
  end
end