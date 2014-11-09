class FeedbacksController < ApplicationController


  def index
  end

  def show
  end
  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def feedback_subject_params
    params.require(:feedback_subject).permit(:title)
  end

end
