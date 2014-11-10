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


        
        desc "Return Specific Episode"
        route_param :id do
          get '/' do
            @episode = Episode.find(params[:id])
            @tags_arr = []
            Tag.all.each do |tag|
              h = {}
              h[:id] = tag.id
              h[:title] = tag.title
              h[:num_of_votes] = tag.num_of_votes(@episode)
              @tags_arr.push(h)
            end
            #binding.pry
            render rabl: "#{@@default_view_path}/show"
          end
        end
      end


    end
  end
end