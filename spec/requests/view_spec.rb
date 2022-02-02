require 'rails_helper'

RSpec.describe "view controller" do
  describe "view" do
    before(:each) do
      @user_1 = User.create(username: "sardine_user_1", address: "0xFF11")
      sleep(1)
      @user_2 = User.create(username: "sardine_user_2", address: "0xFF23")

      Bid.create(user: @user_1, amount: 1)
      Bid.create(user: @user_2, amount: 10)
      Bid.create(user: @user_1, amount: 100)
    end

    describe "unauthenticated user" do
      it "shows the correct data" do
        get "/view"

        json_response = JSON.parse response.body
        # HTTP Response assertions
        expect(response).to have_http_status(:ok)
        expect(json_response["highest_bid"]).to include("amount" => 100.0)
        expect(json_response["highest_bid"]).to include("owner" => false)
      end
    end

    describe "authenticated user" do
      it "shows correct data for the owner of the highest bid" do
        get "/view", headers: {Auth: @user_1.secret_key}

        json_response = JSON.parse response.body
        # HTTP Response assertions
        expect(response).to have_http_status(:ok)
        expect(json_response["current_bid"]).to include("amount" => 100.0)
        expect(json_response["highest_bid"]).to include("amount" => 100.0)
        expect(json_response["highest_bid"]).to include("owner" => true)
      end

      it "shows correct data for a user who is not the owner of the highest bid" do
        get "/view", headers: {Auth: @user_2.secret_key}

        json_response = JSON.parse response.body
        # HTTP Response assertions
        expect(response).to have_http_status(:ok)
        expect(json_response["current_bid"]).to include("amount" => 10.0)
        expect(json_response["highest_bid"]).to include("amount" => 100.0)
        expect(json_response["highest_bid"]).to include("owner" => false)
      end
    end
  end
end
