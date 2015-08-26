class UsersController < ApplicationController

  before_action :authenticate_user!, only: [:categories_of_subscription, :subscribe_category]



  def categories_of_subscription
    @user = current_user
    @categories = Category.order(id: :asc)
  end

  def subscribe_category

    params[:user][:subscribed_category_ids] ||= []
    current_user.subscribed_category_ids = params[:user][:subscribed_category_ids]
    if(current_user.valid?)
      # flash[:notice] = "還迎您來到walawala"
      redirect_to root_path
    else
      # flash[:error] = "您好像輸入錯誤囉"
      redirect_to path_with_hash_tag(subscription_categories_path)
      # render :back
    end
  end


  private
  def user_params
    params.require(:user).permit(subscribed_category_ids: [])
  end


end
