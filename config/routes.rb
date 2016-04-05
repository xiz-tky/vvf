Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  scope '(:locale)', locale: /en|vi|ja/ do
    root 'projects#index'
    resources :users
    resources :languages
    resources :categories
    resources :nations
    resources :divisions
    resources :payment_vendors
    resources :projects do
      member do
        get 'preview' => 'projects#preview'
        get 'edit_rewards' => 'projects#edit_rewards'
        get 'discard' => 'projects#discard'
        get 'apply' => 'projects#apply'
        get 'remand' => 'projects#remand'
        get 'approve' => 'projects#approve'
        get 'suspend' => 'projects#suspend'
        get 'drop' => 'projects#drop'
        post 'complete'
        post 'cancel'
      end
    end
    get 'rewards/:reward_id/new_pledge' => 'pledges#new', as: :new_pledge
    post 'shipping_rate' => 'pledges#shipping_rate'
    resources :pledges, :except => :new do
      get 'complete', :on => :member
      get 'cancel', :on => :collection
    end

    get 'login' => 'user_sessions#new', :as => :login
    post 'logout' => 'user_sessions#destroy', :as => :logout
    post 'user_sessions' => 'user_sessions#create', :as => :user_sessions

    post 'oauth/callback' => 'oauths#callback'
    get 'oauth/callback' => 'oauths#callback' # for use with Github, Facebook
    get 'oauth/:provider' => 'oauths#oauth', :as => :auth_at_provider
  end
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
