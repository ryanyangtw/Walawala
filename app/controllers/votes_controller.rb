class VotesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @episode = Episode.find(params[:episode_id])
    @tag = Tag.find(params[:tag_id])
    @vote = Vote.new(episode: @episode, voter: current_user, tag: @tag)

    if @vote.save
    else
    end

    respond_to do |format|
      format.js
    end
  end



  def destroy

    @episode = Episode.find(params[:episode_id])
    @tag = Tag.find(params[:tag_id])
    @vote = Vote.find_by(episode: @episode, voter: current_user, tag: @tag)

    @vote.destroy
    
    respond_to do |format|
      format.js
    end
  end

end
