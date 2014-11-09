module API
  module V1
    class UnFeedbackSubjects < Grape::API

      @@default_feedback_subjects_path = 'v1/feedback_subjects'



      resources :feedback_subjects do 
        desc "list all of the subjects of feedback"
        get do
          @feedback_subjects = FeedbackSubject.all
          render rabl: "#{@@default_feedback_subjects_path}/index"
        end

      end


    end
  end
end