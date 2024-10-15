Rails.application.routes.draw do
  resources :transactions, only: [:create]
  post 'sessions', to: 'sessions#create'
end
