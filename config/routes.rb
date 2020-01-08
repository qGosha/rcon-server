Rails.application.routes.draw do
  namespace :api do 
    namespace :v1, defaults: { format: "json" } do
    resources :users
    resources :orders
    post 'signup', to: 'users#create'
    post 'login', to: 'sessions#create'
    post 'logout', to: 'sessions#destroy'
    get 'logged_in', to: 'sessions#is_logged_in?'
  end
end
end
