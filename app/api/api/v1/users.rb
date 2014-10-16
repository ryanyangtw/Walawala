module API
	module V1
		class Users < Grape::API

			@@default_view_path = 'v1/users'

	    helpers do
        params :access_token do
        	requires :user, type: Hash do
          	requires :authentication_token, type: String
          	requires :id, type: String
          end
        end
      end


	    resources :users do   	
	    	route_param :id do
	    		desc "Return Specific User"	
					params do
	      		use :access_token
	      	end
	    		get do
	    			@user = current_user
	    			render rabl: "#{@@default_view_path}/show"
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
						user.change_authentication_token!
						#not work?
						#status 200
						#{:status=> '200', :message=> 'success sign out'}
						success_message('success sign out')
						#error!("401 Unauthorized", 401)
					end
				end



				desc "Return List of customize episodes"
				params do
					use :access_token
				end
				get ":id/customize_episodes" do

					@episodes = current_user.customize_episodes
					render rabl: "#{@@default_view_path}/customize_episodes"
				end


				desc "Subscribe categories"
				params do
					use :access_token
	
					requires :category_ids, type: String, default: ''
				end	
				post ":id/categories/subscribe" do
					current_user.subscribed_category_ids = params[:category_ids]
					success_message('success to subscribe those categories')
				end



				desc "Subscribe program"
				params do
					use :access_token
					requires :program_id, type: String
				end	
				post ":id/programs/:program_id/subscribe" do
					@program = Program.find(params[:program_id])
					current_user.subscribe_program!(@program)
					success_message('success to subscribe this program')
				end



				desc "Cancel subscribed program"
				params do
					use :access_token
					requires :program_id, type: String
				end	
				delete ":id/programs/:program_id/cancel" do
					@program = Program.find(params[:program_id])
					current_user.cancel_subscribed_program!(@program)
					success_message('success to cancel thos program')
				end







				#desc "Return List of subscription"
				#post ':id/subscription' do
				#	current_user.subscriptions.order("last_episode_uploaded_at DESC")
				#end

    	end	 #end of resources user 



	  end
	end
end