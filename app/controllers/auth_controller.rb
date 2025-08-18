
class AuthController < ApplicationController
    skip_before_action :authorized, only: [:login]

    def login
        user = User.find_by(username: params[:username])
        
        if user && user.authenticate(params[:password])
            token = encode_token(user_id: user.id)
            render json: {
                user: UserSerializer.new(user),
                token: token
            }, status: :ok
        else
            render json: {
                error: 'Invalid credentials',
                message: 'Username or password is incorrect'
            }, status: :unauthorized
        end
    end
end
