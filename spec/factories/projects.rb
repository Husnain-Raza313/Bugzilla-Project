# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    name { Faker::Name.name }
    # user_id { association :user, factory: [:random_user] }

    trait :same do
      name { 'Project2' }
    end
  end
end
