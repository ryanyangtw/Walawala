module API
	module V2
		class Users < Grape::API
			
			desc "Hello words"
	    get '/' do
	      "Hello world."
	    end

	    #desc "Returns your public timeline."
	    #get :programs do
	    #  Program.all
	    #end

	    resources :users do
	    	desc "Return list of user"
	    	get do
	    		User.all
	    	end
	    end


	  end
	end
end