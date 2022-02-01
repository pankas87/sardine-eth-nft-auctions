class BidsController < ApplicationController
  def create
    secret_key = request.headers["Auth"]

    # TODO: This nesting of ifs is ugly AF, refactor after having tests in place
    if secret_key.nil?
      render json: {error: "Auth header is not present"}, status: :unauthorized
    else
      user = User.find_by(secret_key: secret_key)

      if user.nil?
        render json: {error: "Secret Key does not correspond to an existing user"}, status: :not_found
      else
        @bid = Bid.new bid_params
        @bid.user = user

        if @bid.save
          render json: {}, status: :created
          # render json: { errors: @bid.errors }, status: :unprocessable_entity
        end
      end
    end
  end

  private

  def bid_params
    params.permit(:amount)
  end
end
