class MyDevise::RegistrationsController < Devise::RegistrationsController #ApplicationController # Devise::RegistrationsController
  #layout 'application'

  def new
    # @user = User.new
    super
  end

  def create

    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        #respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        #respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      #set_minimum_password_length
      #respond_with resource
    end
    
    
    respond_to do |format|
      # Add fotmat.js to handle request from js(ajax)
      @error_messages = @user.errors.full_messages
      format.js { render(action: "registrations_create") }
    end
  end





  def update

    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      # respond_with resource, location: after_update_path_for(resource)
      # render js: "alert('成功修改會員資料');"
      redirect_to path_with_hash_tag(edit_user_registration_path)
    else
      clean_up_passwords resource
      # respond_with resource
      # render js: "alert('密碼輸入錯誤');"
      flash[:error] = "密碼輸入錯誤"
      binding.pry
      redirect_to path_with_hash_tag(edit_user_registration_path)
    end


    # @user = User.find(current_user.id)

    # successfully_updated = if needs_password?(@user, params)
    #   @user.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
    # else
    #   # remove the virtual current_password attribute
    #   # update_without_password doesn't know how to ignore it
      
    #   params[:user].delete(:current_password)
    #   @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
    # end

    # if successfully_updated
    #   set_flash_message :notice, :updated
    #   # Sign in the user bypassing validation in case their password changed
    #   sign_in @user, :bypass => true
    #   redirect_to after_update_path_for(@user)
    # else
    #  render "edit"
    # end
  end



  # protected
  # def after_sign_up_path_for(resource)
  #   binding.pry
  #   path_with_hash_tag(subscribe_categories_path)
  # end



  private

  # check if we need password to update user data
  # ie if password or email was changed
  # extend this as needed
  def needs_password?(user, params)
    #user.email != params[:user][:email] ||
    params[:user][:password].present?
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :avatar, :password_confirmation, :current_password)
  end

  def path_with_hash_tag(path)
    "##{path}"
  end


end 