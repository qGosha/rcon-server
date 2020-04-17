Rails.application.routes.draw do
  namespace :api do 
    namespace :v1, defaults: { format: "json" } do
    resources :users, only: [:create, :update, :destroy, :show]
    resources :orders, only: [:index, :create, :update, :destroy]
    resources :realtor_ratings, only: [:create, :update, :destroy]
    resources :realtor_profiles, only: [:create, :update]
    post 'signup', to: 'users#create'
    post 'login', to: 'sessions#create'
    post 'logout', to: 'sessions#destroy'
    get 'logged_in', to: 'sessions#is_logged_in?'
    get 'my_orders', to: 'orders#my_orders'
    get 'list_realtors', to: 'realtors#index'
    get 'search_realtors', to: 'realtors#search'
    get 'responded_orders', to: 'orders#responded_by_me_orders'
    post 'send_realtor_profile', to: 'realtor_profiles#send_realtor_profile'
  end
end
end
