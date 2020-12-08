class PartyGuest < ApplicationRecord
  belongs_to :user
  belongs_to :party

  validates :party_id, presence: true
  validates :user_id, presence: true
end
