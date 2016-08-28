Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/logged_user', to: 'user#logged_user'

  namespace :admin do
    resources :skills
    resources :roles
    resources :users
    resources :tasks
    
    resources :missions do
      resources :tasks
    end
    resources :messages do
      resources :users
    end
  end

  resources :users do
    resources :skills
    resources :missions do
      resources :tasks
    end
    resources :messages
  end

end
