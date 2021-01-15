FactoryBot.define do
  factory :user do
    user_id               { Faker::Internet.password(min_length: 20) + '1a' }
    name                  { Faker::Name.name }
    icon                  { Faker::Internet.url }
    message               { Faker::Music.instrument }
    password = Faker::Internet.password(min_length: 6)
    password { password }
    password_confirmation { password }
  end
end
