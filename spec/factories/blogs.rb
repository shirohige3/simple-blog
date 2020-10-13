FactoryBot.define do
  factory :blog do
    title   {Faker::Name.initials(number: 10)}
    text    {"今日からブログを始めます"}
    association :user
  end
end