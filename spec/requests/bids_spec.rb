require 'rails_helper'

RSpec.describe "register controller" do
  describe "new" do
    describe "unauthorized user" do
      it "returns a 401 status code with an error message when the Auth header is not present" do
        # Setup and send the request
        request_params = '{ "amount": 12.5 }'
        request_headers = { "Content-Type" => "application/json" }

        post "/bids", params: request_params, headers: request_headers

        json_response = JSON.parse response.body

        # HTTP Response assertions
        expect(response).to have_http_status(:unauthorized)
        expect(json_response).to include("error" => "Auth header is not present")
      end

      it "returns a 404 status code when the key does not match any existing user" do
        # Create the user
        user = User.new username: "sardine_user", address: "0xF3D713a2Aa684E97de770342E1D1A2e6D65812A7"
        user.save

        # Setup and send the request
        request_params = '{ "amount": 12.5 }'
        request_headers = { "Auth" => "NOT A VALID KEY", "Content-Type" => "application/json" }

        post "/bids", params: request_params, headers: request_headers

        json_response = JSON.parse response.body

        # HTTP Response assertions
        expect(response).to have_http_status(:not_found)
        expect(json_response).to include("error" => "Secret Key does not correspond to an existing user")
      end
    end

    describe "authorized user" do
      it "creates a new bid when the amount is correct" do
        # Create the user
        user = User.new username: "sardine_user", address: "0xF3D713a2Aa684E97de770342E1D1A2e6D65812A7"
        user.save

        # Setup and send the request
        request_params = '{ "amount": 12.5 }'
        request_headers = { "Auth" => user.secret_key, "Content-Type" => "application/json" }

        post "/bids", params: request_params, headers: request_headers

        # HTTP Response assertions
        expect(response).to have_http_status(:created)

        # Side effects assertions
        bid = Bid.last

        expect(bid.amount).to eq(JSON.parse(request_params)["amount"])
        expect(bid.user.id).to eq(user.id)
      end

      it "returns a 422 status code and an error message and  when the bid is smaller than the previous bid" do
        # Create the user
        user = User.new username: "sardine_user", address: "0xF3D713a2Aa684E97de770342E1D1A2e6D65812A7"
        user.save

        # Create new user
        new_user = User.new username: "new_sardine_user", address: "0xF3D713a2Aa684E97de770342E1D1A2e6D65812A7"
        new_user.save

        # Create the first bid
        first_bid = Bid.new user: new_user, amount: 50
        first_bid.save

        # Setup and send the request
        request_params = '{ "amount": 12.5 }'
        request_headers = { "Auth" => user.secret_key, "Content-Type" => "application/json" }

        post "/bids", params: request_params, headers: request_headers

        json_response = JSON.parse response.body

        # HTTP Response assertions
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response).to include("error" => "Bid should be higher than the last bid")

        # Side effects assertions
        bid = Bid.last
        expect(bid.id).to eq(first_bid.id)
      end

      it "returns a 422 status code and an error message and  when the current user is the same as the previous bidding user" do
        pending "implement"
      end
    end
  end
end
