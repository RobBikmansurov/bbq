FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "Anna_#{n}" }
    email { "#{name.downcase}@example.com" }
    after(:build) { |u| u.password_confirmation = u.password = '123456' }
   end
end
