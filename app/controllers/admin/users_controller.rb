class Admin::UsersController < AdminController


  def index
    @users = User.order("created_at DESC").paginate(:page => params[:page], :per_page=>15)
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "Success to delete user"
      redirect_to :back
    else
      flash[:alert] = "Something Wrong"
    end

  end

end