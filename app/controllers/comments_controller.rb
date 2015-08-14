class CommentsController < ApplicationController
  before_action :find_episode, :only => [:new ,:create, :edit,:update, :destroy]
  before_action :find_comment, :only => [:edit, :update,:destroy]
  before_action :authenticate_user!, only: [:create]


  def new
  end


  def create

    @comment = @episode.comments.build(comment_params)
    @comment.user = current_user
    @comment.save

    respond_to do |format|
      format.js
    end
  end





  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_episode
    @episode = Episode.find(params[:episode_id])
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end

end
