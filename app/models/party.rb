class Party < ApplicationRecord
  belongs_to :host, class_name: 'User'
  has_many :party_guests, dependent: :destroy
  has_many :guests, through: :party_guests, source: :user

  validates :movie_id, presence: true
  validates :duration, presence: true
  validates :when, presence: true
  validates :host_id, presence: true

  def start_date_time
    self.when.strftime('%A %B %-d, %Y at %l:%M %p')
  end
end
