class AuthController < ApplicationController
  allow_unauthenticated_access only: %i[ login register ]
  rate_limit to: 10, within: 3.minutes, only: [:login, :register], with: -> { render json: { error: "Too many attempts. Try again later." }, status: :too_many_requests }

  def login
    if user = User.authenticate_by(params.permit(:email_address, :password))
      token = generate_jwt_token(user)
      render json: { 
        user: user.as_json(only: [:id, :email_address]), 
        token: token 
      }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  def register
    user = User.new(user_params)
    
    if user.save
      token = generate_jwt_token(user)
      render json: { 
        user: user.as_json(only: [:id, :email_address]), 
        token: token 
      }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:email_address, :password, :password_confirmation)
  end

  def generate_jwt_token(user)
    payload = {
      user_id: user.id,
      exp: 24.hours.from_now.to_i
    }
    
    JWT.encode(payload, Rails.application.credentials.secret_key_base)
  end
end
