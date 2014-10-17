module API
	module V1
		class Programs < Grape::API
			#helpers Rails.application.routes.url_helpers
			
			@@default_view_path = 'v1/programs'


			helpers do
        params :access_token do
        	requires :user, type: Hash do
          	requires :authentication_token, type: String
          	requires :id, type: String
          end
        end
      end


	    resources :programs do
	    	paginate per_page: 15
	    	desc "Return list of program"
	    	paginate
				params do
					use :access_token
				end
	    	get '/' do
	    		#binding.pry
	    		@programs = paginate Program.all.includes(:episodes)
	    		render rabl: "#{@@default_view_path}/index"
	    	end



	    	#post do
  			#	#Status.create!(text: params[:text])
				#end
				
				desc "Return Specific Program"
				route_param :id do
					params do
						use :access_token
					end
					get do
						#id_array = params[:id].split(",")
						#@program = Program.find(id_array)
						@program = Program.find(params[:id])
						render rabl: "#{@@default_view_path}/show"
					end
				end

	    end
	  end
	end
end