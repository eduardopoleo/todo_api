class List < Sequel::Model(:lists)
  many_to_one :user
  many_to_one :group
  one_to_many :tasks

  def outstanding_tasks
    tasks_dataset.where(completed: false)
  end

  def add_task(name, user)
    DB.transaction do
      Task.create(name: name, user_id: user.id, list_id: id)

      query = %(
        UPDATE lists
          SET task_count = task_count + 1, last_added_task = '#{name}'
        where id = #{id}
      ).gsub("\n", ' ').squeeze(' ')

      DB[query].to_a
    end

    reload # not necesary but makes testing lot easier.
  end
end