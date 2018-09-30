class Task < Sequel::Model(:tasks)
  many_to_one :list
  many_to_one :user
end