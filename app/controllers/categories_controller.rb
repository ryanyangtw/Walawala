class CategoriesController < ApplicationController
  before_action :find_category, :only => [:edit, :update,:destroy]
  
  def index
    @categories = Category.order("id ASC")
  end

  def show    
    @category = Category.includes(:programs).find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if(@category.save)
      redirect_to categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update  
    if(@category.update(category_params))
      redirect_to categories_path
    else
      render :edit
    end
  end

  def destroy
    if(@category.destroy)
      redirect_to categories_path
    else
    end
  end

  
  def subscription
    @user = current_user
    #@categories = Category.order('id asc')
  end

  def subscribe

    if( current_user.update(user_params))
      flash[:notice] = "還迎您來到walawala"
      redirect_to root_path
    else
      flash[:error] = "您好像輸入錯誤囉"
      render :back
    end

  end


  private
  
  def find_category
    @category = Category.find(params[:id])    
  end

  def category_params
    params.require(:category).permit(:title, :description, :image)
  end

  def user_params
    params.require(:user).permit(subscribed_category_ids: [])
  end

end
