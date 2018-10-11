class Task < Sequel::Model(:tasks)
  many_to_one :list
  many_to_one :user
  many_to_one :assignee, class: :User
end