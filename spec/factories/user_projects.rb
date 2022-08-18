# frozen_string_literal: true

FactoryBot.define do
  factory :user_project do

    # project_id { association :project}

    # trait :qa_FK do
    #   # association :user, factory: [:random_user, :qa]
    #   user_id { association :user, factory: [:random_user, :qa] }
    # end
    # trait :dev_FK do
    #   # association :user, factory: [:random_user, :developer]
    #   user_id { association :user, factory: [:random_user, :developer] }
    # end
  end
end
