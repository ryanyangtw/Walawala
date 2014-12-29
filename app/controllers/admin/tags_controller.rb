class Admin::TagsController < AdminController

  before_action :find_tag, :only => [:edit,:update,:destroy]

  def index
    @tags = Tag.order("id ASC")
  end


  def show
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if(@tag.save)
      falsh[:notice] = "Success to create new tag"
      redirect_to admin_tags_path
    else
      render :new
    end

  end


  def edit
  end

  def update
    if(@tag.update(tag_params))
      flash["notice"] = "Success to update tag"
      redirect_to admin_tags_path
    else
      render :edit
    end
  end


  def destroy
    if(@tag.destroy)
      flash[:notice] = "Success to delete tag"
      redirect_to admin_tags_path
    else
    end
  end


  private 

  def find_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:title)
  end

end
