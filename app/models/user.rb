class User < ApplicationRecord
  has_many :followers, foreign_key: :follower_id, class_name: 'Friendship'
  has_many :followed, through: :followers
  has_many :followed, foreign_key: :followed_id, class_name: 'Friendship'
  has_many :followers, through: :followed

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password_confirmation

  has_secure_password

  def user_name
    email.split('@').first
  end
end
