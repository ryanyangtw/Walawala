class EpisodesController < ApplicationController
  before_action :find_program, :only => [:new ,:create, :edit,:update, :destroy]
  before_action :find_episode, :only => [:edit, :update,:destroy]

  def index
  end

  def show
  end
    

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

    #if(is_program_exist?(params[:subject]))
#
    #else
    # 
    # @program = current.user.build()
    # @episode = 
#
    #end
  end

  def edit
  end

  def update
    if(@episode.update(episode_params))
      redirect_to program_path(@program)
    else
      render :edit
    end

  end

  def destroy
    if(@episode.destroy)
      redirect_to program_path(@program)
    end
  end


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
