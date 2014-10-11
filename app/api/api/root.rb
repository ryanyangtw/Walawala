
module API
	class Root < Grape::API

    #helpers Rails.application.routes.url_helpers

        formatter :json, Grape::Formatter::Rabl

		rescue_from :all, :backtrace => true do |e|
            Rack::Response.new( {:response_type => 'error', :response => e.message }.to_json, e.status ).finish
        end

		error_formatter :json, API::ErrorFormatter
	
		mount API::V1::Base
		mount API::V2::Base
		 
	end

	Base = Rack::Builder.new do
    use API::Logger
    run API::Root
  end

end

