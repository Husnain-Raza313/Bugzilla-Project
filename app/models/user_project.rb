class UserProject < ApplicationRecord
  belongs_to :User
  belongs_to :Project
end
