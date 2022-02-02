class BidsController < ApplicationController
  before_action :get_secret_key, :authenticate_user

  def create
    @bid = Bid.new bid_params
    @bid.user = @user

    if @bid.save
      render json: {}, status: :created
    else
      render json: { errors: @bid.errors }, status: :unprocessable_entity
    end
  end

  private

  def bid_params
    params.permit(:amount)
  end

  def get_secret_key
    @secret_key = request.headers["Auth"]

    if @secret_key.nil?
      render json: {error: "Auth header is not present"}, status: :unauthorized
    end
  end

  def authenticate_user
    @user = User.find_by(secret_key: @secret_key)

    if @user.nil?
      render json: {error: "Secret Key does not correspond to an existing user"}, status: :not_found
    end
  end
end
