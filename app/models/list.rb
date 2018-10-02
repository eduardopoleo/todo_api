class List < Sequel::Model(:lists)
  many_to_one :user
  one_to_many :tasks

  def outstanding_tasks
    tasks_dataset.where(completed: false)
  end
end