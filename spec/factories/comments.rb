FactoryBot.define do
  factory :comment do
    text { 'コメントする' }
    association :blog
    association :user
  end
end
