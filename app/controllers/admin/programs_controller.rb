class Admin::ProgramsController < AdminController

  before_action :set_program, :only => [ :edit, :update, :destroy, :recommend, :cancel_recommendation]
  before_action :find_all_categories, :only => [:new,:edit]


  def index
    @programs = Program.order("updated_at DESC").paginate(:page => params[:page], :per_page=>15)
  end

  def show
    #@program = Program.includes(:episodes,:categories,:program_evaluations).find(params[:id])
    #@program = Program.includes(:episodes, :categories).find(params[:id])

    @program = Program.includes(:episodes, :categories).find(params[:id])
    @episodes = @program.episodes.order("id DESC").paginate(:page => params[:page], :per_page=>15)


    
    #@evaluations = Evaluation.order("id ASC")
    
    #@episodes = @program.episodes
    #@episodes = [] if(@episodes == nil)
  end

  def new
    @program = current_user.programs.build
  end

  def create  

    @program = current_user.programs.build(program_params)

    if(@program.save)
      flash[:notice] = "Success to create new program"
      params[:program][:categories_ids] ||= []
      @program.category_ids = params[:program][:categories_ids]
      redirect_to admin_root_path
    else
      flash[:alert] = "Something wrong"
      render :new
    end
  end

  def edit
    set_referer
    #binding.pry
  end

  def update

    if(@program.update(program_params))
      params[:program][:categories_ids] ||= []
      @program.category_ids = params[:program][:categories_ids]

      flash[:notice] = "Success to update program"
      # redirect_to admin_program_path(@program)
      redirect_to get_referer
    else
      flash[:notice] = "Something wrong"
      render :edit
    end

  end

  def destroy
    if(@program.destroy)
      flash[:notice] = "Success to delete program"
      redirect_to :back
      # redirect_to admin_root_path
    end
  end


  def destroy_multiple
    # Program.find

    if(Program.destroy_all(id: params[:program_ids]))
      redirect_to :back
    end
    # programs = Program.find(program_ids)
    # programs.each do |program|
    #   program.archived
    # end

  end


  def recommend 
    @program.set_to_recommendation
    flash[:notice] = "Success to add this program to 精選輯"
    redirect_to :back
  end 

  def cancel_recommendation
    @program.cancel_from_recommendation
    flash[:notice] = "Success to remove this program from 精選輯"
    redirect_to :back
  end


=begin

  def subscribe
    @program.add_subscriber!(current_user)
    flash[:notice] = "你已成功訂閱此節目"
    redirect_to :back
  end

  def cancel_subscription
    @program.remove_subscriber!(current_user)
    flash[:notice] = "你已取消訂閱此節目"
    redirect_to :back
  end

  def search
    @q = Program.includes(:episodes).ransack(params[:q]) 
    @programs = @q.result(distinct: true).includes(:episodes).paginate(:page => params[:page], :per_page => 20 )
  end

=end

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
    params.require(:program).permit(:subject, :introduction, :image)
  end

  def set_program
    @program = Program.find(params[:id])
  end

  def find_all_categories
    @categories = Category.all
  end






end
