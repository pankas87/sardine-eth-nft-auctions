class UsersController < ApplicationController
  def create
    @user = User.new user_params

    if @user.save
      render json: { secret_key: @user.secret_key }, status: :created
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:username, :address)
  end
end
