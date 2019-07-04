class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?
    
    include CurrentCart
    before_action :set_cart

    
    
   
    def home 
      
    end

    def help
    end

    def about
    end

    

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password)}

      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :avatar)}
    end

    
    private
    def cart_token
      return @cart_token unless @cart_token.nil?
      session[:cart_token]  ||= SecureRandom.hex(8)
      @cart_token = session[:cart_token]
    end
   
    
end
