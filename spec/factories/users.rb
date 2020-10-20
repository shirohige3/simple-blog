FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 4) }
    full_name             { '田中太郎' }
    full_name_kana        { 'タナカタロウ' }
    email                 { Faker::Internet.free_email }
    password              { '1234aa' }
    password_confirmation { password }
    birth_date            { '2000-2-2' }
  end
end
