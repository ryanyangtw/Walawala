module API
	module V1
		class UnauthenticatedRequestsAPI < Grape::API

		
			mount API::V1::UnCategories
			mount API::V1::UnPrograms
			mount API::V1::UnEpisodes
      mount API::V1::UnUsers

	  end
	end
end