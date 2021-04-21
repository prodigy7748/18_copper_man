FactoryBot.define do
  factory :task do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    start_time { Faker::Time.between(from: DateTime.now - 3.day ,to: DateTime.now - 2.day) }
    end_time { Faker::Time.between(from: DateTime.now - 1.day, to: DateTime.now) }
  end
end
