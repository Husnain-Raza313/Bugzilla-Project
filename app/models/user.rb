class User < ApplicationRecord

  has_many :user_projects
  has_many :projects , through: :user_projects
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum user_type: [:user, :manager, :developer, :qa]
  after_initialize :set_default_user_type, :if => :new_record?

  def set_default_user_type
    self.user_type ||= :user
  end
end
