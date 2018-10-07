class List < Sequel::Model(:lists)
  many_to_one :user
  many_to_one :group
  one_to_many :tasks

  def outstanding_tasks
    tasks_dataset.where(completed: false)
  end

  def add_task(name, user)
    Task.create(name: name, user_id: user_id, list_id: id)
  end
end