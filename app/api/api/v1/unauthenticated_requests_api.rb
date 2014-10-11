module API
	module V1
		class UnauthenticatedRequestsAPI < Grape::API
			
			mount API::V1::Categories
			mount API::V1::Programs
			mount API::V1::Episodes
			resources :users do
	    	
	    	desc "Create User"	    	
	    	params do
	    		requires :email, type: String
	    		requires :password, type: String
	    	end
	    	post do
	    		@user = User.new({email: params[:email], password: params[:password]})
	    		if(@user.save)
	    			@user
	    		else
	    			error!("500 Internal Server Error", 500)
	    		end
	    	end


    		desc "User Sign in"
    		params do
    			requires :email, type: String
    			requires :password, type: String
    		end
	    	namespace :sign_in do
	    		post do
	    			user = User.find_by_email(params[:email])
        		if(user && user.valid_password?(params[:password]))
        			user.chenge_authentication_token
       				user
        		else
        			error!("401 Unauthorized", 401)
        		end
	    		end
	    	end

				desc "Sign In With Facebook" 	 			  	
	    	namespace :auth do
	    		route_param :omniauth_provider do		
		    		params do
		    			requires :omniauth_provider, type: String
		    			optional :auth, type: Hash do
		    				requires :provider, type: String
		    				requires :uid, type: String
	    				  optional :info, type: Hash do
		    					requires :email, type: String
		    					optional :name, type: String
		    					optional :image, type: String
	    				  end
	    				end
	  				end

						post do
							if(params[:omniauth_provider] == 'facebook')
								user = User.from_omniauth(params[:auth])					
								if(user.persisted?)
									user.chenge_authentication_token
									user
								else
									error!("401 Unauthorized", 401)
								end
							end

						end
	    		end
	    	end

	  
    	end	  

	  end
	end
end