class List < Sequel::Model(:lists)
  many_to_one :user
  many_to_one :group
  one_to_many :tasks

  def outstanding_tasks
    tasks_dataset.where(completed: false)
  end

  def add_task(name)
    DB.transaction do
      Task.create(name: name, list_id: id)

      query = %(
        UPDATE lists
          SET task_count = task_count + 1, last_added_task = '#{name}'
        where id = #{id}
      ).gsub("\n", ' ').squeeze(' ')

      DB[query].to_a
    end

    # maybe it makes more sense to return the task created?
    reload 
  end

  def to_table
    table = Terminal::Table.new title: name, headings: ['Task Name', 'Assignee', 'Completed'] do |t|
      tasks_dataset.eager(:assignee).paged_each do |task|
        t << [task.name, task.assignee&.name, task.completed]
        t.style = {:all_separators => true}
      end
    end

    puts table
  end
end