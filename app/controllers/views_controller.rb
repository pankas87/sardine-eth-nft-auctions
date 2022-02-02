class ViewsController < ApplicationController
  before_action :authenticate_user

  def index
    @last_bid = Bid.last

    @response = {
      "highest_bid" => {
        "amount" => @last_bid.amount.to_f,
        "owner" => false
      }
    }

    unless @user.nil?
      @user_last_bid = @user.bids.last
      @response["current_bid"] = {"amount" => @user_last_bid.amount.to_f} unless @user_last_bid.nil?
      @response["highest_bid"]["owner"] = true if @user_last_bid.id == @last_bid.id
    end

    render json: @response, status: :ok
  end

  private

  def authenticate_user
    secret_key = request.headers["Auth"]
    @user = User.find_by(secret_key: secret_key) unless secret_key.nil?
  end
end
