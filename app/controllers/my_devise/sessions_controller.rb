class MyDevise::SessionsController < Devise::SessionsController #ApplicationController # Devise::SessionsController
# class SessionsController < ApplicationController
  #layout 'application'

  def new
    super
  end

  def create
   

    @user = User.find_by(email: params[:user][:email])

    if @user && @user.valid_password?(params[:user][:password])
      self.resource = warden.authenticate!(auth_options)
      set_flash_message(:notice, :signed_in) if is_flashing_format?
      sign_in(resource_name, resource)
      yield resource if block_given?
    end

    respond_to do |format|
      # Add fotmat.js to handle request from js(ajax)
      format.js { render(action: "sessions_create") }
    end
    
    # respond_with resource, location: after_sign_in_path_for(resource)
    # binding.pry
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
    yield if block_given?
    # respond_to_on_destroy
    
    respond_to do |format|
      format.js { render(action: "sessions_destroy") }
    end
  end



end
