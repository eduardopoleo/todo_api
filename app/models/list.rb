class List < Sequel::Model(:lists)
  many_to_one :user
  one_to_many :tasks

  def outstanding_tasks
    tasks_dataset.where(completed: false)
  end

  def self.lists_with_metadata
    # TODO
  end
end