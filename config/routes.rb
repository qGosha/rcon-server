Rails.application.routes.draw do
  namespace :api do 
    namespace :v1, defaults: { format: "json" } do
    resources :users, only: [:create, :update, :destroy, :show]
    resources :orders, only: [:create, :update, :destroy]
    post 'signup', to: 'users#create'
    post 'login', to: 'sessions#create'
    post 'logout', to: 'sessions#destroy'
    get 'logged_in', to: 'sessions#is_logged_in?'
    get 'my_orders', to: 'orders#my_orders'
  end
end
end
