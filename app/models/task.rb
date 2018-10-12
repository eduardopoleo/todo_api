class Task < Sequel::Model(:tasks)
  many_to_one :list
  many_to_one :assignee, class: :User

  def assign(user)
    update(assignee_id: user.id)
  end
end