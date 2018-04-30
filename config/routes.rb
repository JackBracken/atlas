Rails.application.routes.draw do
  root 'overview#show'

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'
  get 'logout' => 'sessions#destroy', as: 'logout'

  resource :user, only: [:edit, :update]

  get 'overview/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
