module API
  module V1
    class UnUsers < Grape::API

      @@default_user_path = 'v1/users'

      resources :users do
        
        desc "Create User"        
        params do
          requires :user, type: Hash do
            requires :email, type: String
            requires :password, type: String
            optional :name, type: String
          end
        end
        post do

          #@user = User.new({email: params[:email], password: params[:password]})
          #puts "============================================================="
          #puts params
          #puts "============================================================="
          #puts params[:user]
          #puts "============================================================="
          @user = User.new(params[:user])
          if(@user.save)
            @user.renew_data!

            render rabl: "#{@@default_user_path}/show"
          else
            #raise
            error!(@user.errors.full_messages)
            #error_response({ message: "rescued from" })
            #error!("該使用者已經存在", 500)
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
              error!(@user.errors.full_messages)
              #error!("401 Unauthorized", 401)
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
                optional :fb_access_token, type: String
                #end
              end
            end

            post do
              if(params[:omniauth_provider] == 'facebook')

                params[:user][:info] = {}
                params[:user][:info][:email]= params[:user][:email]
                params[:user][:info][:name]= params[:user][:name]
                params[:user][:info][:image]= params[:user][:avatar]
  
                params[:user][:credentials] = {}
                params[:user][:credentials][:token] = params[:user][:fb_access_token]

                @user = User.from_omniauth(params[:user])         
                if(@user.persisted?)
                  @user.change_authentication_token!
                  @user.renew_data!

                  render rabl: "#{@@default_user_path}/show"
                else
                  error!(@user.errors.full_messages)
                  #error!("401 Unauthorized", 401)
                end
              end

            end
          end
        end
    
      end   #resources user



    end
  end
end