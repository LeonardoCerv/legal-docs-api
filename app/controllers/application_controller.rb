class ApplicationController < ActionController::API
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.

    before_action :authorized

    rescue_from ActionController::RoutingError, with: :handle_routing_error
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

    def encode_token(payload)
        JWT.encode(payload, 'hellomars1211') 
    end

    def decoded_token
        header = request.headers['Authorization']
        if header
            token = header.split(" ")[1]
            begin
                JWT.decode(token, 'hellomars1211', true, algorithm: 'HS256')
            rescue JWT::DecodeError
                nil
            end
        end
    end

    def current_user 
        if decoded_token
            user_id = decoded_token[0]['user_id']
            @user = User.find_by(id: user_id)
        end
    end

    def authorized
        unless !!current_user
        render json: { message: 'Please log in' }, status: :unauthorized
        end
    end

    def handle_routing_error
        render json: {
            error: 'Route not found',
            message: 'The requested endpoint does not exist',
            status: 404,
            available_endpoints: {
                documents: [
                    'GET /documents/:type',
                    'POST /documents/:type', 
                    'PUT /documents/:type',
                    'DELETE /documents/:type'
                ],
                organization: [
                    'GET /organization',
                    'POST /organization',
                    'PUT /organization',
                    'DELETE /organization'
                ],
                templates: [
                    'GET /templates/:type'
                ],
                auth: [
                    'POST /users',
                    'GET /me',
                    'POST /auth/login'
                ]
            }
        }, status: :not_found
    end

    private

    def handle_not_found
        render json: {
            error: 'Resource not found',
            message: 'The requested resource could not be found',
            status: 404
        }, status: :not_found
    end

end
