require 'rails_helper'

RSpec.describe "register controller" do
  it "creates a new user when all the parameters are valid" do
    request_params = '{"username": "sardine_user", "address": "0xF3D713a2Aa684E97de770342E1D1A2e6D65812A7"}'
    request_headers = { "Content-Type" => "application/json" }
    post "/register", params: request_params, headers: request_headers

    json_response = JSON.parse response.body

    # HTTP Response assertions
    expect(response).to have_http_status(:created)
    expect(json_response).to include("secret_key")

    # Side effects assertions
    user = User.last
    expect(json_response["secret_key"]).to eq(user.secret_key)
  end

  it "return a 422 error and a list of error messages when any of the parameters is invalid" do
    request_params = ''
    request_headers = { "Content-Type" => "application/json" }
    post "/register", params: request_params, headers: request_headers

    json_response = JSON.parse response.body

    # HTTP Response assertions
    expect(response).to have_http_status(:unprocessable_entity)
    expect(json_response).to include("errors")
    expect(json_response["errors"]).to include("username")
    expect(json_response["errors"]).to include("address")

    # Side effects assertions
    user = User.last
    expect(user).to be_nil
  end
end
