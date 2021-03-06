class Admin::EpisodesController < AdminController

  before_action :find_program, :only => [:new ,:create]
  before_action :find_episode, :only => [:edit, :update,:destroy]
  before_action :authenticate_user!, only: [:vote]

  def index
    respond_to do |format|
      format.html do
        @episodes = Episode.order("updated_at DESC").paginate(:page => params[:page], :per_page=>20)
      end
      
      # There are some ernoding problems whrn outputing CSV
      format.csv do
        @episodes = Episode.order("updated_at ASC")
        send_data @episodes.to_csv
      end

      format.xls do
        @episodes = Episode.order("updated_at ASC")
      end

    end
  end

  def show
  end
    
=begin
  def new
    @episode = @program.episodes.build
    #@episode = current_user.
    #@program = current_user.build
  end

  def create  

    #@program = current_user.programs.find(params[:program_id])
    @episode = @program.episodes.build(episode_params)
    if(@episode.save)
      redirect_to program_path(@program)
      #@episode.update_program
    else
      render :new
    end


  end

=end


  def edit
    set_referer
  end

  def update
    if(@episode.update(episode_params))
      flash[:notice] = "success update episode"
      redirect_to get_referer
      # redirect_to admin_episodes_path
    else
      #render :edit
    end

  end

  def destroy
    if(@episode.destroy)
      flash[:notice] = "success delete episode"
      # redirect_to admin_episodes_path
      redirect_to :back
      #redirect_to program_path(@program)
    end
  end

  def destroy_multiple

    if(Episode.destroy_all(id: params[:episode_ids]))
      redirect_to :back
    end
  end


=begin
  def vote


    @episode = Episode.find(params[:id])
    @tag = Tag.find(params[:tag_id])

    @vote = Vote.new(episode: @episode, voter: current_user, tag: @tag)

    if(@vote.save)
      flash[:notice] = "你已成功評價此節目"
      redirect_to :back
    else
      flash[:notice] = "你已經評分過囉！"
      redirect_to :back
    end

  end
=end

  private
  #def is_program_exist?(subject)
  # 
  # if(current_user.programs.where(:name => subject))
  #   return true
  # else
  #   return false
  # end
#
  #end

  def episode_params
    params.require(:episode).permit(:title, :description, :audio)
  end

  def find_program
    @program = Program.find(params[:program_id])
  end

  def find_episode
    @episode = Episode.find(params[:id])
  end



end
