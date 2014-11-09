module API
  module V1
    class UnEpisodes < Grape::API

      @@default_view_path = 'v1/episodes'

      resources :episodes do
        #paginate per_page: 15
        #desc "Return list of episodes"
        #get '/' do
        #  #binding.pry
        #  @episodes = paginate Episode.all
        #  render rabl: "#{@@default_view_path}/index"
        #end


        
        desc "Return Specific Program"
        route_param :id do
          get '/' do
            @episode = Episode.find(params[:id])
            render rabl: "#{@@default_view_path}/show"
          end
        end

      end


    end
  end
end