Rails.application.routes.draw do
  root 'static_pages#home'

  devise_for :user, controllers: {  
    # confirmations: 'users/confirmations',
    passwords: 'devise/passwords',
    registrations: 'devise/registrations',
    sessions: 'devise/sessions',
    # unlocks: 'users/unlocks',
  }, skip: [:sessions]

  ## custom routes for users
  as :user do
    get 'login' => 'devise/sessions#new', as: :new_user_session
    post 'login' => 'devise/sessions#create', as: :user_session
    delete 'logout' => 'devise/sessions#destroy', as: :destroy_user_session
    get 'register' => 'devise/registrations#new'
  end

  resources :posts, only: [:create, :destroy]
  resources :users, only: [:show]
end
