class PasswordResetsController < ApplicationController
  def show
    user = User.find_by(reset_password_token: params[:id])
    if user
      @token = user.reset_password_token
    else
      redirect_to expired_token_path
    end

  end

  def create
    @user = User.find_by(reset_password_token: params[:token])
    if @user
      if @user.update(password: params[:password], password_confirmation: params[:password_confirmation])
        @user.destroy_token!
        flash.now[:success] = "Your password has been changed. Please sign in."
        # redirect_to sign_in_path
      else
        flash.now[:error] = @user.errors.full_messages
      end
    # else
    #   # redirect_to expired_token_path
    # end
    end
    respond_to do |format|
      format.js # { render(action: "create") }
    end

  end

  def expired_token; end

end