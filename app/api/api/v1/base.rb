
module API
	module V1
		class Base < Grape::API



			include API::V1::Defaults

      #helpers StatusHelpers
      helpers API::V1::StatusHelpers
			mount API::V1::UnauthenticatedRequestsAPI
	    mount API::V1::AuthenticatedRequestsAPI
		  add_swagger_documentation api_version: 'v1',
                                hide_documentation_path: true


		end
	end
end