# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'Manager1' }
    email { 'manager4@email.com' }
    password { 'manager123' }
  end
end
