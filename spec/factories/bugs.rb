# frozen_string_literal: true

FactoryBot.define do
  factory :bug do
    title { 'Bug1234' }
    piece_status { 'new' }
    piece_type { 'Bug' }
  end
end
