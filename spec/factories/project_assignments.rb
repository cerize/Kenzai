FactoryGirl.define do
  factory :project_assignment do
    association       :user, factory: :user
    association       :project, factory: :project
    is_manager        false
  end
end
