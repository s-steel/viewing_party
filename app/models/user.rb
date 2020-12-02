class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates :password, presence: { require: true }

  has_secure_password

  def user_name
    email.split('@').first
  end
end
