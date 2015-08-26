class ProgramsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :edit, :update, :destroy]
  before_action :set_program_in_from_current_user, only: [:edit, :update, :destroy, :more_episodes]
  before_action :set_program, :only => [:subscribe, :cancel_subscription]
  before_action :find_all_categories, :only => [:new,:edit]

  authorize_resource

  def index
    @programs = current_user.programs.order(id: :desc)
  end

  def show

    #@program = Program.includes(:episodes, :categories).find(params[:id])
    @program = Program.includes(:episodes, :categories, :owner).find(params[:id])
    @episodes = @program.episodes.order(id: :desc).paginate(page: params[:page], per_page: 20)
    @comment = Comment.new
    #@episodes = @program.episodes
    #@episodes = [] if(@episodes == nil)

  end

  def new
    @program = current_user.programs.build
  end

  def create  
  
    @program = current_user.programs.build(program_params)

    if(@program.save)
      # params[:program][:categories_ids] ||= []
      # @program.category_ids = params[:program][:categories_ids]
      redirect_to path_with_hash_tag(new_program_episode_path(@program))
    else
      # Todo: error messages
      redirect_to path_with_hash_tag(new_program_path)
      # render :back
    end
  end

  def edit
    #@program = Program.find(params[:id])
  end

  def update

    if(@program.update(program_params))
      redirect_to path_with_hash_tag(new_program_episode_path(@program))
      # params[:program][:categories_ids] ||= []
      # @program.category_ids = params[:program][:categories_ids]
      # redirect_to program_path(@program)
    else
      redirect_to path_with_hash_tag(edit_program_path(@ptrgram))
      # render :edit
    end

  end

  def destroy
    if(@program.destroy)
      redirect_to path_with_hash_tag(programs_path)
      # redirect_to root_path
    end
  end

  def subscribe
    @program.add_subscriber!(current_user)
    # flash[:notice] = "你已成功訂閱此節目"
    # redirect_to :back
    # render js: "alert('你已成功訂閱此節目');"
    respond_to do |format|
      format.js
    end
  end

  def cancel_subscription
    @program.remove_subscriber!(current_user)
    # flash[:notice] = "你已取消訂閱此節目"
    # render js: "alert('你已取消訂閱此節目');"
    # redirect_to :back
    respond_to do |format|
      format.js
    end
  end

  def search

    @q = Program.includes(:episodes).ransack(params[:q]) 
    @programs = @q.result(distinct: true).includes(:episodes) #.paginate(:page => params[:page], :per_page => 5 )
    
    respond_to do |format|
      format.js
    end
  end

  # def search_result
  #   @q = Program.includes(:episodes).ransack(params[:q]) 
  #   @programs = @q.result(distinct: true).includes(:episodes).paginate(:page => params[:page], :per_page => 3 )
  #   binding.pry
  # end

  def more_episodes

    # @episodes = @program.episodes.order(id: :desc).limit(20).offset(30)
    @episodes = @program.episodes.order(id: :asc)
    
    respond_to do |format|
      format.js
    end
  end



  #def vote  
#
  #  @program = Program.find(params[:id])
  #  if(current_user && !current_user.already_voted?(@program))
  #    @program.add_evaluator!(current_user)
#
  #    @evaluation = Evaluation.find(params[:evaluation_id])
  #      
  #    if(@program.vote!(@evaluation.id , current_user.id))
  #      flash[:notice] = "你已成功評價此節目"
  #      redirect_to :back
  #    else
  #      flash[:notice] = "系統錯誤，請稍後再試！"
  #      redirect_to :back
  #    end
#
  #  else
  #    flash[:notice] = "你已經評分過囉！"
  #    redirect_to :back
  #  end
  #end

  

  private
  def program_params
    params.require(:program).permit(:subject, :introduction, :image, :first_category, :second_category, :third_category)
  end


  def set_program_in_from_current_user
    @program = current_user.programs.find(params[:id])
  end

  def set_program
    @program = Program.find(params[:id])
  end

  def find_all_categories
    @categories = Category.all
  end


end
