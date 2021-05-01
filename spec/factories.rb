FactoryBot.define do
  factory :task do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    start_time { Faker::Time.between(from: DateTime.now - 3.day ,to: DateTime.now - 2.day) }
    end_time { Faker::Time.between(from: DateTime.now - 1.day, to: DateTime.now) }
    association :user
  end

  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Lorem.characters(number: 15) }
  end
end
