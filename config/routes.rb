Rails.application.routes.draw do
  resources :roles
devise_for :users
scope "/admin" do
  resources :users
end
get 'selectors', to: 'selectors#new', as: :selectorsnew
get 'en/selectors/new', to: 'selectors#new', as: :enselectorsnew
get 'fr/selectors/new', to: 'selectors#new', as: :frselectorsnew

    resources :customers
    resources :rcharts
    resources :indicators
    resources :countries  
    get 'welcome/index'
    scope "(:locale)", locale: /fr|en/ do
    get 'selectors/autocomplete_country_name'
    get 'selectors/autocomplete_indicator_id1'
    resources :selectors
    end
    resources :selectors do
        get :autocomplete_indicator_id1, :on => :collection
        get :autocomplete_country_name, :on => :collection
    end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'selectors#new'

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
