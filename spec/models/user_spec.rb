require 'rails_helper'

RSpec.describe User, type: :model do
  # Basic Validations
  it { should validate_uniqueness_of(:username) }

  describe "secret key tests" do
    # TODO: Before block, mock the time.now or whatever function I use to get the timestamp for generating the secret key
    it "generates a secret key for new users" do

    end

    it "does not generate a secret key for existing users being updated" do

    end
  end
end
