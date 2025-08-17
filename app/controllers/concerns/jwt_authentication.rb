module JwtAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_with_jwt, except: [:show]
  end

  private

  def authenticate_with_jwt
    token = extract_token_from_header
    
    if token
      begin
        decoded_token = JWT.decode(token, Rails.application.credentials.secret_key_base, true, { algorithm: 'HS256' })
        user_id = decoded_token[0]['user_id']
        @current_user = User.find(user_id)
      rescue JWT::DecodeError, JWT::ExpiredSignature
        render json: { error: 'Invalid or expired token' }, status: :unauthorized
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'User not found' }, status: :unauthorized
      end
    else
      @current_user = nil
    end
  end

  def extract_token_from_header
    auth_header = request.headers['Authorization']
    auth_header&.split(' ')&.last if auth_header&.start_with?('Bearer ')
  end

  def current_user
    @current_user
  end

  def authenticated?
    current_user.present?
  end

  def require_authentication!
    unless authenticated?
      render json: { error: 'Authentication required' }, status: :unauthorized
    end
  end
end
