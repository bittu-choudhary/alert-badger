class ApplicationController < ActionController::API
    after_action :set_jwt_token
    
    include Pundit::Authorization

    rescue_from Pundit::NotAuthorizedError, with: :not_authorized

    def no_matching_route
        render json: { errors: {"routingError" => ["No route matches"]} }, status: :not_found
    end
    
    private 

    def authenticate
        rodauth.require_authentication
    end

    def not_authorized
        render json: { errors: {"request" => ["not authorized"]} }, status: :forbidden
    end

    def set_jwt_token
        if rodauth.use_jwt? && rodauth.valid_jwt?
            response.headers["Authorization"] = rodauth.session_jwt
        end
    end
end
