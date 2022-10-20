FactoryBot.define do
  factory :webhook do
    source { "MyString" }
    external_id { "MyString" }
    data { "" }
    state { 1 }
    processing_errors { "MyText" }
  end
end
