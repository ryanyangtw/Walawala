module API
  module V1
    class FeedbackSubjects < Grape::API

      helpers do
        params :access_token do
          requires :user, type: Hash do
            requires :authentication_token, type: String
            requires :id, type: String
          end
        end
      end


      resources :feedback_subjects do 

        desc "Create Feedback"
        params do 
          use :access_token
          requires :feedback, type: Hash do
            requires :content, type: String
          end
        end
        post ':id/feedbacks' do 
          @feedback_subject = FeedbackSubject.find(params[:id])
          @feedback = @feedback_subject.feedbacks.build(params[:feedback])
          @feedback.user = current_user
          if @feedback.save
            success_message('success create feedback')
          else
            error_message('fail to create feedback' , 500)
          end

        end

      end # end of resources


    end
  end
end