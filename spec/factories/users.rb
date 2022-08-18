# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }

    trait :same do
      email { 'same@email.com' }
    end
  end
  factory :random_user, class: 'User' do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    user_type { 0 }

    trait :developer do
      user_type { 1 }
    end
    trait :developer2 do
      user_type { 1 }
    end
    trait :qa do
      user_type { 2 }
    end
    trait :qa2 do
      user_type { 2 }
    end
    trait :same do
      email { 'same@email.com' }
    end
  end
end
