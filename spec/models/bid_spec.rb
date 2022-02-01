require 'rails_helper'

RSpec.describe Bid, type: :model do
  # Basic Validations
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:amount) }
  it { should validate_numericality_of(:amount).is_greater_than(0) }

  # Association Validations
  it { should belong_to(:user) }

  # Business rules validations
  # TODO: Implement when I get to the POST /bids controller, not now
  describe "Business Rules" do
    it "only allows bids with an amount greater than the previous bid" do
      # Create users
      first_user = User.create username: "sardine_user_1", address: "0xDFFF"
      second_user = User.create username: "sardine_user_2", address: "0xDFCC"

      # Create first bid
      Bid.create user: first_user, amount: 10

      # Create second bid
      second_bid = Bid.new user: second_user, amount: 1

      expect(second_bid.valid?).to be false
      expect(second_bid.errors["amount"]).to eq(["Should be larger than the previous bid amount"])
    end

    it "prevents users from placing consecutive bids" do
      # Create user
      user = User.create username: "sardine_user_1", address: "0xDFFF"

      # Create first bid
      Bid.create user: user, amount: 10

      # Create second bid
      second_bid = Bid.new user: user, amount: 100

      expect(second_bid.valid?).to be false
      expect(second_bid.errors["user"]).to eq(["Users cannot create consecutive bids"])
    end
  end
end
