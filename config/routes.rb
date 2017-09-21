Rails.application.routes.draw do
  devise_for :users
  get 'controls/login'
  root "members#index"
  resources :factions
  resources :members
  resources :ogvs
  resources :controls
  resources :myep
  get '/eps/display', to:'myep#display', as:'ep_display'
  get '/eps/display/openSource', to: 'myep#openSource', as:'openSource_display'

  match ':controller(/:action(/:id))' , :via => [:get , :post]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
