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
            #TODO: exception handler for 確認錯誤為重複投票        
            current_user.cancel_vote(@tag, @episode)
            success_message('成功取消投票')

            #error_message('您已經投過票囉', 500) #@vote.errors.full_messages
          end
        end

        
        desc "Cancel vote On Specific Episode and tag"
        params do
          use :access_token
          requires :episode_id, type: String
          requires :id, type: String
        end
        delete ':episode_id/tags/:id/votes' do 
          @episode = Episode.find(params[:episode_id])
          @tag = Tag.find(params[:id])
          #@vote = Vote.where(episode: @episode, voter: current_user, tag: @tag).first
          #binding.pry
          if current_user.cancel_vote(@tag, @episode)
            success_message('成功取消投票')
          else
            #TODO: 若刪除失敗......      
          end

        end

        desc "Return official collection"
        paginate per_page: 15
        params do
          use :access_token
        end
        get 'official_collection' do
          @episodes = Program.official_collection(params[:page], params[:per_page])
          render rabl: "#{@@default_view_path}/index"
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


        desc "Increase number of views in episode"
        params do
          use :access_token
          requires :id, type: String
        end
        post ':id/increase_number_of_views' do 

          @episode = Episode.find(params[:id])

          if @episode.increase_number_of_views(current_user)
            success_message('success to increase number of views')
          end
          #@episode.add_listener(current_user)
    
        end


      end # end of episodes resources



    end
  end
end