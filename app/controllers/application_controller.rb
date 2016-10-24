class ApplicationController < ActionController::Base
protect_from_forgery with: :exception
helper_method :current_user, :authenticate_user
    def current_user 
      
      if session[:user_id]
        @current_user||= User.find_by_id session[:user_id]
      end
    end

    def authenticate_user
      if !current_user
        redirect_to root_path, notice: " must sign in "
      end 
    end
    
    def to_s
    end
end
