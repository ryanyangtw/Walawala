class CategoriesController < ApplicationController
  before_action :find_category, :only => [:edit, :update,:destroy]
  
  def index
    @categories = Category.order("id ASC")
  end

  def show    
    @categories = Category.order("id ASC") 
    #@category = Category.includes(:programs).find(params[:id])
    category = Category.find(params[:id])
    @programs = category.programs.paginate(page: params[:page], per_page: 20)
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

  



  private
  
  def find_category
    @category = Category.find(params[:id])    
  end

  def category_params
    params.require(:category).permit(:title, :description, :image)
  end



end
