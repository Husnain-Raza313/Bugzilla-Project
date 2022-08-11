require 'rails_helper'

RSpec.describe Bug, type: :model do

  describe "Creating a Bug with invalid title"do
  it 'gives validation error'do
    bug1=Bug.new(title: "Bug", project_id: 1, qa_id: 1)
    expect(bug1.save).to eq(false)
  end
  it 'gives validation error'do
    bug1=Bug.new(title: "Bug1234", project_id: 1, qa_id: 1)
    expect(bug1.save).to eq(true)
  end
  end

end
