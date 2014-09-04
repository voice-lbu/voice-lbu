Rails.application.routes.draw do

  get 'aktive' => 'members#active'
  get 'innlogging(/:id/:hash)' => 'sessions#new', as: 'log_in'
  post 'innlogging' => 'sessions#send_email'
  get "utlogging" => 'sessions#destroy', as: 'log_out'
  get 'utmeldt' => 'members#left'
  get 'sign_up' => 'users#new', as: 'sign_up'

  resources :members
  resources :users

  root 'members#active'

  get ':controller(/:action(/:id))'
end
