class Bid < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
