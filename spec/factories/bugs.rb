# frozen_string_literal: true

FactoryBot.define do
  factory :bug do
    title { Faker::Name.name }
    piece_status { 'new' }
    piece_type { 'Bug' }
    trait :same do
      title { 'Bug1234' }
    end
  end
end
