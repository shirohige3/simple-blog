FactoryBot.define do
  factory :blog do
    title   { Faker::Name.initials(number: 10) }
    body    { '今日からブログを始めます' }
    association :user
  end
end
