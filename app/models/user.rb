class User < Sequel::Model(:users)
  one_to_many :lists, :tasks
end