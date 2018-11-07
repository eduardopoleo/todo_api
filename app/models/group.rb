class Group < Sequel::Model(:groups)
  one_to_many :lists
  many_to_many :users, left_key: :group_id, right_key: :user_id,
    join_table: :user_groups

  # TODO: add validation so that the same user can not be added twice to the same group.
  def add_user(user)
    UserGroup.create(user_id: user.id, group_id: id)
  end

  def add_list(list)
    list.update(group_id: id)
  end

  def to_table
    # TODO: Add date added to the group list
    table = Terminal::Table.new title: name, headings: ['User Name', 'Email'] do |t|
      users_dataset.paged_each do |user|
        t << [user.name, user.email]
        t.style = {:all_separators => true}
      end
    end

    puts table
  end
end