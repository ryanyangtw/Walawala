class PagesController < ApplicationController

  def home
    if user_signed_in?
      #@programs = Program.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 20) || []
      # @programs = [] if(@programs==nil)
      #@subscriptions = current_user.subscriptions.order("last_episode_uploaded_at DESC")
      #@subscriptions = current_user.subscribed_programs.order("updated_at DESC")

      # page = 1
      # if params[:page].present? 
      #   page = params[:page]
      # end

      @customize_episodes = current_user.customize_episodes(1, 20)
      render 'pages/home_login'
    else
      render 'pages/home_unlogin'
    end
  end

  def index
  end


  def search
    @q = Program.includes(:episodes).ransack(params[:q]) 
    # @programs = @q.result(distinct: true).includes(:episodes) #.paginate(:page => params[:page], :per_page => 5 )
    @programs = Program.none
  end

end
