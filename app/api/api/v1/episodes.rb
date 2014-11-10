module API
  module V1
    class Episodes < Grape::API
      #helpers Rails.application.routes.url_helpers
      helpers do
        params :access_token do
          requires :user, type: Hash do
            requires :authentication_token, type: String
            requires :id, type: String
          end
        end
      end

      resources :episodes do
        desc "Vote Tags On Specific Episode"
        params do
          use :access_token
          requires :episode_id, type: String
          requires :id, type: String
        end

        post ':episode_id/tags/:id/votes' do 
          @episode = Episode.find(params[:episode_id])
          @tag = Tag.find(params[:id])
          @vote = Vote.new(episode: @episode, voter: current_user, tag: @tag)
          binding.pry
          if @vote.save
            success_message('投票成功')
          else
            error_message('您已經投過票囉', 500) #@vote.errors.full_messages
          end

        end
      end # end of episodes resources



    end
  end
end