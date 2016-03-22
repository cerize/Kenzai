FactoryGirl.define do
  factory :project do
    association       :creator, factory: :user
    title             { Faker::Company.bs }
    description       { Faker::Lorem.paragraph }
    start_date        2.days.from_now
    end_date          60.days.from_now
  end
end
