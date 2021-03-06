class TagsController < ApplicationController

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
      redirect_to tags_path
    else
      render :new
    end

  end


  def edit
  end

  def update
    if(@tag.update(tag_params))
      redirect_to tags_path
    else
      render :edit
    end
  end


  def destoy
    if(@tag.destroy)
      redirect_to tagss_path
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
