module API
	module V1
		class Users < Grape::API

			@@default_view_path = 'v1/user'

	    helpers do
        params :access_token do
          requires :authentication_token, type: String
          requires :id, type: String
        end
      end


	    resources :users do   	

	    	route_param :id do
	    		desc "Return Specific User"	
					params do
	      		use :access_token
	      	end
	    		get do
	    			current_user
	    		end
				end
				
				desc "Return List of subscription"
				params do
					use :access_token
				end
				route_param :id do
					namespace :subscription do
						get do
							@user = current_user
							render rabl: "#{@@default_view_path}/subscription"
							#current_user.subscriptions.order("last_episode_uploaded_at DESC")
						end
					end
				end


				desc "User sign out"
				params do
					use :access_token
				end
				route_param :id do
					delete do
						user = current_user
						user.chenge_authentication_token
						#not work?
						render json: {:status=> '200', :message=> 'success sign out'}
					end
				end


				#desc "Return List of subscription"
				#post ':id/subscription' do
				#	current_user.subscriptions.order("last_episode_uploaded_at DESC")
				#end

    	end	 #end of resources user 



	  end
	end
end