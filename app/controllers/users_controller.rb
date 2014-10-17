class UsersController < ApplicationController





  def categories_of_subscription
    @user = current_user
    #@categories = Category.order('id asc')
  end

  def subscribe_category

    if( current_user.update(user_params))

      flash[:notice] = "還迎您來到walawala"
      redirect_to root_path
    else
      flash[:error] = "您好像輸入錯誤囉"
      render :back
    end
  end


  private
  def user_params
    params.require(:user).permit(subscribed_category_ids: [])
  end


end
