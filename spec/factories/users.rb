FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { 'ito101' }
    password_confirmation { password }
    last_name             { '伊藤' }
    first_name            { '隆' }
    kana_last_name        { 'イトウ' }
    kana_first_name       { 'タカシ' }
    birth                 { '1930-01-01' }
  end
end
