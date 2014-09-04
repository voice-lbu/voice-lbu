Rails.application.routes.draw do
  get 'aktive' => 'members#active'
  get 'utmeldt' => 'members#left'

  resources :members

  root 'members#active'

  get ':controller(/:action(/:id))'
end
