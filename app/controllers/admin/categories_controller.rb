class Admin::CategoriesController < AdminController

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
      flash[:notice] = "Success to create new category"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update  
    if(@category.update(category_params))

      flash[:notice] = "Success to update category"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    if(@category.destroy)
      flash[:notice] = "Success to delete category"
      redirect_to admin_categories_path
    else
    end
  end

  



  private
  
  def find_category
    @category = Category.find(params[:id])    
  end

  def category_params
    params.require(:category).permit(:title, :description, :image, :image2x, :image3x)
  end


end
