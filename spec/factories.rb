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
    user
    list
    name { "My super task" }
  end
end