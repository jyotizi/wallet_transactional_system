Rails.application.routes.draw do
  resources :transactions, only: [:create]
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
