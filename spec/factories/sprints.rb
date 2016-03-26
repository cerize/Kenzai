FactoryGirl.define do
  factory :sprint do
    association       :project, factory: :project
    title             { Faker::Company.bs }
    description       { Faker::Lorem.paragraph }
    start_date        2.days.from_now
    end_date          60.days.from_now
  end
end
