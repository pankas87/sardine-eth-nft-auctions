require 'rails_helper'

RSpec.describe Bid, type: :model do
  # Basic Validations
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:amount) }
  it { should validate_numericality_of(:amount).is_greater_than(0) }

  # Association Validations
  it { should belong_to(:user) }

  # Business rules validations
  describe "Business Rules" do
    it "only allows bids with an amount greater than the previous bid" do
      pending "It must be a greater amount than the previous bids"
    end

    it "prevents users from placing consecutive bids" do
      pending "A bid can not come from the same user consecutively"
    end
  end
end
