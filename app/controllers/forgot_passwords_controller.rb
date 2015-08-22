class ForgotPasswordsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user
      @user.create_token!
      AppMailer.delay.send_forgot_password(@user)
      # redirect_to forgot_password_confirmation_path
    else
      flash.now[:error] = params[:email].blank? ? "Email cannot be blank." : "There is no user with that email in the system."
      # redirect_to forgot_password_path
    end

    respond_to do |format|
      format.js { render(action: "create") }
    end

  end

  # If we just render states page. We don't need to define method.
  # def confirm
  # end
end