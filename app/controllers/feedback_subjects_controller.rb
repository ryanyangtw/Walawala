class FeedbackSubjectsController < ApplicationController

  before_action :find_feedback_subject, only: [:show, :edit, :update, :destroy]

  def index
    @feedback_subjects = FeedbackSubject.all
  end

  def show
  end
  
  def new
    @feedback_subject = FeedbackSubject.new
  end

  def create
    @feedback_subject = FeedbackSubject.new(feedback_subject_params)
    if @feedback_subject.save
      redirect_to feedback_subjects_path
    else
      render :new
    end

  end

  def edit
  end

  def update

    if @feedback_subject.update(feedback_subject_params)
      redirect_to feedback_subjects_path
    else
      render :edit
    end

  end

  def destroy
     if @feedback_subject.destroy
      redirect_to feedback_subjects_path
    end

  end

  private

  def find_feedback_subject
    @feedback_subject = FeedbackSubject.find(params[:id])   
  end

  def feedback_subject_params
    params.require(:feedback_subject).permit(:title)
  end


end
