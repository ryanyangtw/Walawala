module API
  module V1
    class Episodes < Grape::API
      #helpers Rails.application.routes.url_helpers

      @@default_view_path = 'v1/episodes'
      
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
          #binding.pry
          if @vote.save
            success_message('投票成功')
          else
            error_message('您已經投過票囉', 500) #@vote.errors.full_messages
          end

        end


        desc "Return Specific Episode"
        params do
          use :access_token
          requires :id, type: String
        end
        get ':id' do
          @episode = Episode.find(params[:id])
          @tags = Tag.all
          #@tags_arr = []
          #Tag.all.each do |tag|
          #  h = {}
          #  h[:id] = tag.id
          #  h[:title] = tag.title
          #  h[:num_of_votes] = tag.num_of_votes(@episode)
          #  @tags_arr.push(h)
          #end
          #binding.pry
          render rabl: "#{@@default_view_path}/show"
        end


      end # end of episodes resources



    end
  end
end