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

  def change_role
    @user = User.find(params[:id])
    @user.change_role(params[:new_role])
    flash[:notice] = "Sucess to change role"
    redirect_to admin_users_path
  end

end