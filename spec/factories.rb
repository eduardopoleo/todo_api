FactoryBot.define do
  factory :user do
    name { "John" }
    sequence(:email) { |n| "mike#{n}@awesome.com"}
    password_digest { 'whatever_password' }
  end

  factory :list do
    user
    name { "My super list" }
  end

  factory :task do
    list
    name { "My super task" }
  end

  factory :group do
    name { "My super group" }
  end
end