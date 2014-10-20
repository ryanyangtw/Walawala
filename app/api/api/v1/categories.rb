module API
  module V1
    class Categories < Grape::API
      #helpers Rails.application.routes.url_helpers
      
      @@default_view_path = 'v1/categories'


      helpers do
        params :access_token do
          requires :user, type: Hash do
            requires :authentication_token, type: String
            requires :id, type: String
          end
        end
      end

      resources :categories do
        desc "Return All Programs In Specific Category"
        paginate per_page: 15
        params do
          use :access_token
        end
        get ':id/programs'do
          @programs = paginate Category.find(params[:id]).programs
          render rabl: "v1/programs/index"
        end

        #desc "Return list of category"
        #paginate per_page: 15
        #get do
        #  #binding.pry
        # @categories =  paginate Category.all.includes(:programs)
        #  render rabl: "#{@@default_view_path}/index"
        #end

        
        #desc "Return Specific Category"
        #route_param :id do
        #  get do
        #    #id_array = params[:id].split(",")
        #    #@program = Program.find(id_array)
        #    @category = Category.find(params[:id])
        #    render rabl: "#{@@default_view_path}/show"
        #  end
        #end

      end
      
    end
  end
end