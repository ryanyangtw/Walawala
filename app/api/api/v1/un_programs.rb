module API
  module V1
    class UnPrograms < Grape::API

      @@default_program_path = 'v1/programs'

      resources :programs do

        #desc "Search program" 
        #paginate per_page: 15
        #params do
        #  optional :keyword
        #end
        #get 'search' do
        #  @programs = paginate Program.search(params[:keyword])
        #  render rabl: "#{@@default_program_path}/search"
        #end

      end  #resources programs



    end
  end
end