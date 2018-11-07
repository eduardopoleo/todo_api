class User < Sequel::Model(:users)
  one_to_many :lists
  one_to_many :assigned_tasks, class: :Task, key: :assignee_id
  many_to_many :groups, left_key: :user_id, right_key: :group_id,
    join_table: :user_groups

  def self.create(name:, email:, password:)
    encypted_password = BCrypt::Password.create(password)

    params = {
      name: name,
      email: email,
      password_digest: encypted_password
    }
    
    super(params)
  end

  def outstading_tasks
    Task.where(assignee_id: id, completed: false)
  end

  def create_group(name)
    Group.create(name: name).tap do |group|
      UserGroup.create(group_id: group.id, user_id: self.id)
    end
  end

  def add_group(name)
    DB.transaction do
      group = Group.create(name: name)
      UserGroup.create(user_id: id, group_id: group.id)
    end
  end

  def add_list(name)
    List.create(name: name, user_id: id)
  end

  def assign(task)
    task.update(assignee_id: id)
  end

######### displays #################

  def groups_to_table
    table = Terminal::Table.new headings: ['Group Name'] do |t|
      groups_dataset.paged_each do |group|
        t << [group.name]
        t.style = {:all_separators => true}
      end
    end

    puts table
  end

  def assinged_tasks_to_table
    table = Terminal::Table.new headings: ['Task assigned'] do |t|
      assigned_tasks_dataset.paged_each do |task|
        t << [task.name]
        t.style = {:all_separators => true}
      end
    end

    puts table
  end
end