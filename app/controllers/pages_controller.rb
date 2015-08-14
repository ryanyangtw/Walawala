class PagesController < ApplicationController

  def home
    if user_signed_in?
      #@programs = Program.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 20) || []
      # @programs = [] if(@programs==nil)
      #@subscriptions = current_user.subscriptions.order("last_episode_uploaded_at DESC")
      #@subscriptions = current_user.subscribed_programs.order("updated_at DESC")

      @customize_episodes = current_user.customize_episodes(1, 10)
      render 'pages/home_login'
    else
      render 'pages/home_unlogin'
    end
  end

  def index
  end

end
