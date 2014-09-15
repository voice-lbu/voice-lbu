Rails.application.routes.draw do

  get 'aktive' => 'members#active'
  get 'brukere' => 'users#index'
  get 'innlogging(/:id/:hash)' => 'sessions#new', as: 'log_in'
  post 'innlogging' => 'sessions#send_email'
  get 'sign_up' => 'users#new', as: 'sign_up'
  get 'utlogging' => 'sessions#destroy', as: 'log_out'
  get 'utmeldt' => 'members#left'

  resources :members
  resources :users

  root 'members#active'

  get ':controller(/:action(/:id))'
end
