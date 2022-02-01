require 'rails_helper'

RSpec.describe User, type: :model do
  # Basic Validations
  it { should validate_uniqueness_of(:username) }
  it { should validate_presence_of(:address) }

  # Association Validations
  it { should have_many(:bids) }

  # TODO: Optional, depending on time
  it { pending "validate correct format of ETH wallet address, might be tricky since wallet addresses could have different formats" }


  describe "secret key generation" do
    before do
      Timecop.freeze(Time.now)
    end

    after do
      Timecop.return
    end

    it "generates a secret key for new users" do
      base_string = Time.now.to_i.to_s
      expected_secret_key = Digest::SHA2.hexdigest(base_string)

      user = User.new
      user.username = "foobar3200"
      user.address = "0xFFDF"
      user.save

      expect(user.secret_key).to eq(expected_secret_key)
    end
  end
end
