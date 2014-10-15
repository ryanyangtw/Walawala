class PagesController < ApplicationController

  def home

    @programs = Program.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 20)
    @programs = [] if(@programs==nil)

    if user_signed_in?
      #@subscriptions = current_user.subscriptions.order("last_episode_uploaded_at DESC")
      @subscriptions = current_user.subscribed_programs.order("updated_at DESC")
    end

  end

end
