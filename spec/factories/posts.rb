FactoryBot.define do
  factory :post do
    id { Faker::Number.within(range: 1..1000) }
    video_id { '1yEcEo9mzre' }
    association :user
  end
end
