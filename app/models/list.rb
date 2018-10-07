class List < Sequel::Model(:lists)
  many_to_one :user
  many_to_one :group
  one_to_many :tasks

  def outstanding_tasks
    tasks_dataset.where(completed: false)
  end

  def add_task(name, user)
    DB.transaction do
      Task.create(name: name, user_id: user_id, list_id: id)
      # naive implemetation to update list metadata
      update(task_count: task_count + 1)
      update(last_added_task: name)
    end
  end
end