class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password_confirmation

  has_secure_password

  def user_name
    email.split('@').first
  end
end
