class ProjectSerializer < ActiveModel::Serializer
  attributes :id ,:name , :created_at , :updated_at, :user_id
  has_many :users
end
