Rails.application.routes.draw do
  
  root to: "pages#home"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" , :registrations => "registrations" }

  #devise_for :users
  #devise_for :users, :controllers=>{ :registrations=>"registrations"}

  resources :programs do 
    resources :episodes
    member do
      post :subscribe
      post :cancel_subscription
    end

    collection do
      post :search
    end
  end
  
  resources :episodes ,:only=>[:show] do
    member do
      post "tag/:tag_id/vote", to: "episodes#vote", as: :vote
    end
  end

  resources :categories
  resources :tags

  get "subscription/categories", to: "users#categories_of_subscription"
  post "subscribe_categories", to: "users#subscribe_category"

  resources :feedback_subjects

  

  namespace :admin do
    root to: 'programs#index'

    resources :programs 
    resources :episodes #,:only=>[:index, :destroy]
    resources :categories
    resources :feedback_subjects
    resources :tags
    resources :users, :only => [:index, :destroy]
  end
  
  

  #add for grape api
  #mount Walawala::API => '/api'
  mount API::Root => '/'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
