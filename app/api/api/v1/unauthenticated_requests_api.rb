module API
	module V1
		class UnauthenticatedRequestsAPI < Grape::API

			@@default_user_path = 'v1/users'
			@@default_program_path = 'v1/programs'
			
			mount API::V1::Categories
			#mount API::V1::Programs
			mount API::V1::Episodes
			resources :users do
	    	
	    	desc "Create User"	    	
	    	params do
	    		optional :user, type: Hash do
	    			requires :email, type: String
	    			requires :password, type: String
	    		end
	    	end
	    	post do
	    		#@user = User.new({email: params[:email], password: params[:password]})
	    
	    		@user = User.new(params[:user])
	    		if(@user.save)
	    			@user.renew_data!

	    			render rabl: "#{@@default_user_path}/show"
	    		else
	    			error!("該使用者已經存在", 500)
	    		end
	    	end


    		desc "User Sign in"
    		params do
    			requires :user, type: Hash do
    				requires :email, type: String
    				requires :password, type: String
    			end
    		end
	    	namespace :sign_in do
	    		post do

	    			@user = User.find_by_email(params[:user][:email])
        		if(@user && @user.valid_password?(params[:user][:password]))
        			@user.change_authentication_token!
        			@user.renew_data!
       				render rabl: "#{@@default_user_path}/show"
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
		    			requires :user, type: Hash do
		    				requires :provider, type: String
		    				requires :uid, type: String
	    				  #optional :info, type: Hash do
		    				requires :email, type: String
		    				optional :name, type: String
		    				optional :avatar, type: String
	    				  #end
	    				end
	  				end

						post do
							if(params[:omniauth_provider] == 'facebook')

								#auth = {"info"=>{}}
								#auth["provider"] = params[:user][:provider]
								#auth["uid"] = params[:user][:uid]
								#auth["info"]["email"] = params[:user][:email]
								#auth["info"]["name"] = params[:user][:name]
								#auth["info"]["image"] = params[:user][:image]
								params[:user][:info] = {}
								params[:user][:info][:email]= params[:user][:email]
								params[:user][:info][:name]= params[:user][:name]
								params[:user][:info][:image]= params[:user][:avatar]


								@user = User.from_omniauth(params[:user])					
								if(@user.persisted?)
									@user.change_authentication_token!
									@user.renew_data!

	    						render rabl: "#{@@default_user_path}/show"
								else
									error!("401 Unauthorized", 401)
								end
							end

						end
	    		end
	    	end
	  
    	end	  #resources user

    	resources :programs do

	    	desc "Search program" 
		    params do
		    	optional :keyword
		    end
		    get 'search' do
		    	@programs = Program.search(params[:keyword])
		    	render rabl: "#{@@default_program_path}/search"
		    end
		  end  #resources programs

	  end
	end
end