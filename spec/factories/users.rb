# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'Manager1' }
    email { 'manager4@email.com' }
    password { 'manager123' }
  end
  factory :random_user, class: 'User' do
    name { 'Manager9' }
    email { 'manager9@email.com' }
    password { 'manager123' }
    user_type { 0 }

    trait :developer do
      email { 'developer4@email.com' }
      user_type { 1 }
    end
    trait :developer2 do
      email { 'developer5@email.com' }
      user_type { 1 }
    end
    trait :qa do
      email { 'qa4@email.com' }
      user_type { 2 }
    end
    trait :qa2 do
      email { 'qa5@email.com' }
      user_type { 2 }
    end
  end
end
