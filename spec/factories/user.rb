FactoryBot.define do
  factory :user do
    nickname              { 'test' }
    email                 { Faker::Internet.free_email }
    password              { '000a00' }
    password_confirmation { password }
    last_name             { 'お手本' }
    first_name            { '太郎' }
    last_name_kana        { 'カタカナ' }
    first_name_kana       { 'カタカナ' }
    birthday              { '2000-01-01' }
  end
end
