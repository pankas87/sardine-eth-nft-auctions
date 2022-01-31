require 'rails_helper'

RSpec.describe User, type: :model do
  # Basic Validations
  it { should validate_uniqueness_of(:username) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:secret_key)}

  # TODO: Optional, depending on time
  it { pending "validate correct format of ETH wallet address, might be tricky since wallet addresses could have different formats" }
  it { pending "Validate presence of association with bids, once the bid models exist" }

  # TODO: Before block, mock the time.now or whatever function I use to get the timestamp for generating the secret key
  describe "secret key tests" do
    it "generates a secret key for new users" do
      pending "this needs to be implemented"
    end

    it "does not generate a secret key for existing users being updated" do
      pending "this needs to be implemented"
    end
  end
end
