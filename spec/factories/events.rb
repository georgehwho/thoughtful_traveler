FactoryBot.define do
  factory :event do
    name  { Faker::Name.name }
    place_id { nil }
    date { Faker::Date.forward(days: rand(5..10)) }
  end
end