# frozen_string_literal: true

FactoryBot.define do
  factory :bug do
    title { Faker::Name.name }
    piece_status { 'new' }
    piece_type { 'Bug' }
    # association :user, factory: [:user_project, :qa_FK]
    trait :same do
      title { 'Bug1234' }
    end
    trait :feature_completed do
      piece_type { 'Feature' }
      status { 'completed' }
    end
    trait :bug_resolved do
      status { 'resolved' }
    end
  end
end
