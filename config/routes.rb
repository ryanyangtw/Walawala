Rails.application.routes.draw do
  
  root to: "pages#index"
  get 'home', to: "pages#home"

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" , registrations: 'my_devise/registrations', sessions: 'my_devise/sessions'} #:registrations => "registrations" }

  #devise_for :users
  #devise_for :users, :controllers=>{ :registrations=>"registrations"}

  resources :programs do 
    resources :episodes
    member do
      post :subscribe
      post :cancel_subscription
      get :more_episodes
    end

    collection do
      post :search
    end
  end
  
  resources :episodes ,:only=>[:show] do
    # member do
    #   post "tag/:tag_id/vote", to: "episodes#vote", as: :vote
    #   post "tag/:tag_id/cancel_vote", to: "episodes#cancel_vote", as: :cancel_vote
    # end

    resources :comments
  end

  post "episode/more_customize_episodes", to: "episodes#more_customize_episodes", as: :more_customize_episodes
  post "episode/:episode_id/tag/:tag_id/vote", to: "votes#create", as: :votes
  delete "episode/:episode_id/tag/:tag_id/cancel_vote", to: "votes#destroy", as: :cancel_vote

  resources :categories
  resources :tags

  get "subscription/categories", to: "users#categories_of_subscription"
  post "subscribe_categories", to: "users#subscribe_category"

  resources :feedback_subjects


  get 'forgot_password', to: 'forgot_passwords#new'
  resources :forgot_passwords, only: [:create]
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirm'

  resources :password_resets, only: [:show, :create]
  get 'expired_token', to: 'pages#expired_token'

  get 'search', to: 'pages#search'

  

  namespace :admin do
    root to: 'programs#index'

    resources :programs do
      member do 
        post :recommend
        post :cancel_recommendation
      end
    end
    resources :episodes #,:only=>[:index, :destroy]
    resources :categories
    resources :feedback_subjects
    resources :tags
    resources :users, :only => [:index, :destroy] do
      member do 
        put :change_role
      end
    end
  end

  #add for sidekiq dashboard
  require 'sidekiq/web'
  mount Sidekiq::Web, at: "/sidekiq"
  
  
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
