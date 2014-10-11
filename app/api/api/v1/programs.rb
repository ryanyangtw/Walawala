module API
	module V1
		class Programs < Grape::API
			#helpers Rails.application.routes.url_helpers
			
			@@default_view_path = 'v1/program'

	    resources :programs do
	    	desc "Return list of program"
	    	get do
	    		#binding.pry
	    		@programs = Program.all.includes(:episodes)
	    		render rabl: "#{@@default_view_path}/index"
	    	end

	    	#post do
  			#	#Status.create!(text: params[:text])
				#end
				
				desc "Return Specific Program"
				route_param :id do
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