class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
    #devise_parameter_sanitizer.for(:sign_up) << :avatar
    devise_parameter_sanitizer.for(:account_update) << :avatar

    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name, :email, :avatar, :avatar_cache, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:name, :email, :avatar, :avatar_cache, :password, :password_confirmation)
    end


  end


# redirect the category describe page if the new user
  def after_sign_in_path_for(resource)
      
      if resource.is_a?(User) && resource.sign_in_count == 1
        subscription_categories_path
      else
        super
      end
  end



end
