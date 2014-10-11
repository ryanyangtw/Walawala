
module API
	module V2
		class Base < Grape::API

			#include API::V2::Defaults
			#mount API::V2::Users
#
		  #add_swagger_documentation api_version: 'v2',
      #                          hide_documentation_path: true
     
		end
	end
end