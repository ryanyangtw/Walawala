module API
	module V1
		class AuthenticatedRequestsAPI < Grape::API
				

			#before fillter should be put before method 
      before do
        error!("401 Unauthorized", 401) unless authenticated
      end

      helpers do

        def warden
          env['warden']
        end

        def authenticated

          return true if warden.authenticated?
          #user_id = params[:id].presence
   				#@user = user_id && User.find(user_id)
   				
          ##@user = User.find(params[:id])
          ##@user && params[:authentication_token] && Devise.secure_compare(@user.authentication_token, params[:authentication_token] )
          @user = User.find(params[:user][:id])
          @user && params[:user][:authentication_token] && Devise.secure_compare(@user.authentication_token, params[:user][:authentication_token] )

          #params[:authentication_token] && @user = User.find_by_authentication_token(params[:authentication_token])
        end

        def current_user
          warden.user || @user
        end

        #params :access_token do
        #  requires :authentication_token, type: String
        #end
      end		




      mount API::V1::Categories
      mount API::V1::Programs
			mount API::V1::Users
      mount API::V1::FeedbackSubjects
      mount API::V1::Episodes

	  end
	end
end