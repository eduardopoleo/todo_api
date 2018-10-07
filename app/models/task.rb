class Task < Sequel::Model(:tasks)
  many_to_one :list
  many_to_one :user

  def assigned_to
    User.where(id: assignee_id).first
  end
end