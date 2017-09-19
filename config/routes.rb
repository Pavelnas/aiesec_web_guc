Rails.application.routes.draw do
  get 'controls/login'
  root "members#index"
  resources :factions
  resources :members
  resources :ogvs
  resources :controls
  resources :myep
  match ':controller(/:action(/:id))' , :via => [:get , :post]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
