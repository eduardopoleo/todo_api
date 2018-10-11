class User < Sequel::Model(:users)
  one_to_many :lists
  one_to_many :tasks
  one_to_many :assigned_tasks, class: :Task, key: :assignee_id

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
    DB.transaction do
      group = Group.create(name: name)
      UserGroup.create(user_id: id, group_id: group.id)
    end
  end

  def assign(task)
    task.update(assignee_id: id)
  end
end