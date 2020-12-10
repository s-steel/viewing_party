class User < ApplicationRecord
  has_many :followers_ref, foreign_key: :follower_id, class_name: 'Friendship', dependent: :destroy
  has_many :followed, through: :followers_ref
  has_many :followed_ref, foreign_key: :followed_id, class_name: 'Friendship', dependent: :destroy
  has_many :followers, through: :followed_ref
  has_many :party_guests, dependent: :destroy
  has_many :parties, through: :party_guests
  has_many :hosted_parties, foreign_key: :host_id, class_name: 'Party'

  validates :email, uniqueness: true, presence: true
  validates :password_confirmation, presence: true

  has_secure_password

  def user_name
    email.split('@').first
  end

  def self.find_user(user_email)
    User.find_by('lower(email) like ?', "#{user_email.downcase}")
  end

  def status(party)
    if party.host_id == id
      'Host'
    elsif party.guests.include?(self)
      'Invited'
    else
      'You are not invited'
    end
  end
end
