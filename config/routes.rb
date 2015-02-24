Rails.application.routes.draw do
  get 'aktive' => 'members#active', as: :active_members
  get 'brukere' => 'users#index'
  get 'innlogging(/:id/:hash)' => 'sessions#new', as: 'log_in'
  post 'innlogging' => 'sessions#send_email'
  post 'invoices/send_to_all' => 'invoices#send_to_all'
  get 'sign_up' => 'users#new', as: 'sign_up'
  get 'utlogging' => 'sessions#destroy', as: 'log_out'
  get 'utmeldt' => 'members#left'

  resources :annual_meetings
  resources :invoices
  resources :members
  resources :users

  root 'members#active'

  get ':controller(/:action(/:id))'
end
