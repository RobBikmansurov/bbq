FactoryBot.define do
  factory :event do
    association :user

    sequence(:title) { |n| "Cool event #{n}" }
    description { "Description of #{title}" }
    address { 'Perm' }
    datetime { 14.days.after }
  end
end
