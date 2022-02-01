class Bid < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validate :amount_must_be_larger_than_previous_bid, :users_cannot_create_consecutive_bids

  private

  def amount_must_be_larger_than_previous_bid
    last_bid = Bid.last

    unless last_bid.nil? || self.amount > last_bid.amount
      self.errors.add(:amount, "Should be larger than the previous bid amount")
    end
  end

  def users_cannot_create_consecutive_bids
    last_bid = Bid.last

    unless last_bid.nil? || self.user.id != last_bid.user.id
      self.errors.add(:user, "Users cannot create consecutive bids")
    end
  end
end
