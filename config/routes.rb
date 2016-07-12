Rails.application.routes.draw do
  post 'stripe/webhook'
  
  #modification to use the customize registrations controller
  devise_for :users, :controllers => {:registrations => "registrations"}
  scope "(:locale)", locale: /fr|en/ do
    scope "/admin" do    
      resources :users
    end  
  end
  get 'selectors', to: 'selectors#new', as: :selectorsnew
  get 'en/selectors/new', to: 'selectors#new', as: :enselectorsnew
  get 'fr/selectors/new', to: 'selectors#new', as: :frselectorsnew

  scope "(:locale)", locale: /fr|en/ do
    resources :roles
    resources :plans    
    resources :indicators
    resources :countries
    resources :subscriptions
    resources :invoicing_ledger_items
  end
  get 'invoicing_ledger_items/index/:recipient_id', controller: "invoicing_ledger_items", action: "index", as: :invoicing_list 
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

  root 'selectors#new'
end
