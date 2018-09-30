class List < Sequel::Model(:lists)
  many_to_one :user
  one_to_many :tasks
end