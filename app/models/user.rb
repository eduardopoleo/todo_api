class User < Sequel::Model(:users)
  one_to_many :lists
  one_to_many :tasks
end