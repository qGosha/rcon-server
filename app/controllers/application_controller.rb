class ApplicationController < ActionController::API
    include ActionController::Cookies
    include ActionController::RequestForgeryProtection
    include SessionsHelper
    before_action :set_csrf_cookie
    protect_from_forgery with: :exception unless Rails.env.test?

    
    private

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        render json: false, status: :unauthorized
        # store_location
      end
    end

    def respond_with_current_user(user)
        render :json => user.as_json(only: [:email, :role]), :status => 200
    end

    def set_csrf_cookie
        cookies["CSRF-TOKEN"] = form_authenticity_token
    end

    def is_client
      unless current_user.role == 'client'
        render json: false, status: :unauthorized
      end
    end

    def is_realtor
      unless current_user.role == 'realtor'
        render json: false, status: :unauthorized
      end
    end
end
